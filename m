Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S156406AbPK3Xuc>; Tue, 30 Nov 1999 18:50:32 -0500
Received: by vger.rutgers.edu id <S155938AbPK3XuX>; Tue, 30 Nov 1999 18:50:23 -0500
Received: from shaft.engin.umich.edu ([141.213.33.85]:4948 "EHLO shaft.engin.umich.edu") by vger.rutgers.edu with ESMTP id <S156356AbPK3XuA>; Tue, 30 Nov 1999 18:50:00 -0500
Date: Tue, 30 Nov 1999 18:49:58 -0500 (EST)
From: Chris Wing <wingc@engin.umich.edu>
To: linux-kernel@vger.rutgers.edu
Subject: [RFC] proposed IPC changes to support 32-bit UIDs
Message-ID: <Pine.LNX.4.10.9911301826240.30512-100000@shaft.engin.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu

Hello. In my latest set of 32-bit UID support patches, I've changed the
msgctl(), semctl(), and shmctl() functions to no longer use the same
structures for both kernel and user space (for IPC_STAT, IPC_SET,
MSG_STAT, SEM_STAT, and SHM_STAT). Instead, the msg_queue, semid_ds, and
shmid_ds structures are considered private to the kernel, and there are
now 2 sets of structures for communicating with user space:

	user_msqid_ds, user_semid_ds, user_shmid_ds
and
	old_user_msqid_ds, old_user_semid_ds, old_user_shmid_ds

The former are used for the "new" IPC_STAT, IPC_SET, et. al, while the
latter are used for backwards compatibility (i.e. 16-bit UIDs).


I favored this approach because it made adding 32-bit UID support as
simple as possible. I've created functions such as

kernel2user_semid_ds(struct semid_ds *in, struct user_semid_ds *out)
kernel2user_ipc_perm(struct ipc_perm *in, struct user_ipc_perm *out)
kernel2old_user_ipc_perm(struct ipc_perm *in, struct old_user_ipc_perm *out)

rather than toss all the new code into the already hairy msgctl(),
semctl(), and shmctl() functions. This makes the 32-bit UID patch much
smaller and easier to manage.

If anyone is interested in looking over this patch, you can find it at:
	http://www.engin.umich.edu/caen/systems/Linux/code/misc/2.3/19991130/linux-ipc.patch

The patch doesn't define the user_ipc_perm, user_msqid_ds, user_semid_ds,
and user_shmid_ds structures; these are defined on an
architecture-by-architecture basis for greatest flexibility. You can
examine the architectural patches at:
	http://www.engin.umich.edu/caen/systems/Linux/code/misc/2.3/19991130/
		linux-alpha.patch
		linux-arm.patch
		linux-i386.patch
		linux-m68k.patch
		linux-mips.patch
		linux-ppc.patch
		linux-sh.patch
		linux-sparc.patch

to see the actual definitions.


Questions:

	- does anyone think that this is a bad idea?

	- should there be more pad space left in the user_ipc_perm,
	  user_msqid_ds, user_semid_ds, and user_shmid_ds structures for
	  future use? At present, I've left 2 machine words worth of pad
	  space in the msqid, semid, and shmid structures, and no extra
	  padding in user_ipc_perm.


Thanks,
Chris Wing
wingc@engin.umich.edu


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
