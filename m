Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317864AbSHaSw7>; Sat, 31 Aug 2002 14:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317872AbSHaSw7>; Sat, 31 Aug 2002 14:52:59 -0400
Received: from ppp-217-133-221-247.dialup.tiscali.it ([217.133.221.247]:15280
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S317864AbSHaSwz>; Sat, 31 Aug 2002 14:52:55 -0400
Subject: Re: [PATCH] Initial support for struct vfs_cred   [0/1]
From: Luca Barbieri <ldb@ldb.ods.org>
To: trond.myklebust@fys.uio.no
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15728.61345.184030.293634@charged.uio.no>
References: <15728.61345.184030.293634@charged.uio.no>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-HHiw9gHn8zQKohqPFjYV"
X-Mailer: Ximian Evolution 1.0.5 
Date: 31 Aug 2002 20:57:14 +0200
Message-Id: <1030820234.4408.119.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HHiw9gHn8zQKohqPFjYV
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

But aren't credential changes supposed to be infrequent?

If so, isn't it faster to put the fields directly in task_struct, keep a
separate shared structure and copy them on kernel entry?

Here is some pseudocode to better illustrate the idea.

vfs_shared_cred::lock can be removed if it's not necessary to do atomic
modifications of multiple cred fields (otherwise you could copy and then
exchange a pointer).

vfs_shared_cred::tasklist_lock can be replaced with RCU.

struct vfs_cred_groups
{
	int ngroups;
	gid_t groups[];
};

struct vfs_cred
{
	uid_t uid, gid;
	struct vfs_cred_groups* groups;
};

struct vfs_shared_cred
{
	atomic_t count;
	spinlock_t lock;
	spinlock_t tasklist_lock;
	vfs_cred cred;
};

struct task_struct
{
	struct vfs_cred cred;
	struct vfs_cred* shared_cred;
	list_t shared_cred_list;
};

struct thread_info
{
	unsigned propagate_cred;
};

propagate_cred()
{
	current_thread_info()->propagate_cred = 0;

	spin_lock(&current->shared_cred->lock);
	current->cred = current->shared_cred->cred;
	spin_unlock(&current->shared_cred->lock);
}

kernel_entry() /* asm for every architecture :( */
{
	if(unlikely(current_thread_info()->propagate_cred))
		propagate_cred();
}

change_credentials()
{
	list_t list;

	spin_lock(&current->shared_cred->lock);
	frob(current->shared_cred);
	spin_unlock(&current->shared_cred->lock);

	wmb();

	spin_lock(&current->shared_cred->tasklist_lock);
	list_for_each(list, &current->shared_cred_list)
	{
		struct task_struct* task = list_entry(list, struct task_struct, shared_cred_list);
		task->thread_info->propagate_cred = 1;
	}
	spin_unlock(&current->shared_cred->tasklist_lock);
}

clone()
{
	spin_lock(&current->shared_cred->lock);
	new->cred = current->shared_cred->cred); /* not current->cred! */
	spin_unlock(&current->shared_cred->lock);

	if(flags & CLONE_CRED)
	{
		new->shared_cred = get_shared_cred(current->shared_cred);
		spin_lock(&current->shared_cred->tasklist_lock);
		list_add(new, &current->shared_cred_list);
		spin_unlock(&current->shared_cred->tasklist_lock);
	}
}

static void release_task(struct task_struct * p)
{
	spin_lock(&current->shared_cred->tasklist_lock);
	__list_del(current->shared_cred_list);
	spin_unlock(&current->shared_cred->tasklist_lock);

	put_shared_cred(current->shared_cred);
}


--=-HHiw9gHn8zQKohqPFjYV
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9cRGKdjkty3ft5+cRAsHCAJ9mMmlNY+AmiGewSTnMP4FEe4PAgACgtK3j
WGjZXH33D5mN3rhDbeESiiM=
=qkUk
-----END PGP SIGNATURE-----

--=-HHiw9gHn8zQKohqPFjYV--
