Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316775AbSFGJzY>; Fri, 7 Jun 2002 05:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSFGJzX>; Fri, 7 Jun 2002 05:55:23 -0400
Received: from slip-202-135-75-168.ca.au.prserv.net ([202.135.75.168]:4737
	"EHLO wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S316775AbSFGJzV>; Fri, 7 Jun 2002 05:55:21 -0400
Date: Fri, 7 Jun 2002 19:06:50 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, frankeh@watson.ibm.com,
        alan@lxorguk.ukuu.org.uk, viro@math.psu.edu
Subject: Re: [PATCH] Futex Asynchronous Interface
Message-Id: <20020607190650.57f25467.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0206060930240.5920-100000@home.transmeta.com>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jun 2002 09:36:23 -0700 (PDT)
Linus Torvalds <torvalds@transmeta.com> wrote:
> You already have to have a system call to bind the particular fd to the
> futex _anyway_, so do the only sane thing, and allocate the fd _there_,

But Ma, I don't *want* to write a filesystem!

Linus, Al, is there an easier way to do this?  I stole this from sockfs,
but I balked at another 50 lines for a proper inode creation, so I just use
the same dentry and inode over and over.

It's still an awful lot of irrelevant code: what can I cut?

/* Everyone needs a dentry and inode */
static struct dentry *futex_dentry;

/* Signal allows caller to avoid the race which would occur if they
   set the sigio stuff up afterwards. */
static int futex_fd(struct list_head *head,
		    struct page *page,
		    int offset,
		    int signal)
{
	int fd;
	struct futex_q *q;
	struct file *filp;

	if (signal < 0 || signal > _NSIG)
		return -EINVAL;

	fd = get_unused_fd();
	if (fd < 0)
		return fd;
	filp = get_empty_filp();
	if (!filp) {
		put_unused_fd(fd);
		return -ENFILE;
	}
	filp->f_op = &futex_fops;
	filp->f_dentry = dget(futex_dentry);

	if (signal) {
		filp->f_owner.pid = current->pid;
		filp->f_owner.uid = current->uid;
		filp->f_owner.euid = current->euid;
		filp->f_owner.signum = signal;
	}

	q = kmalloc(sizeof(*q), GFP_KERNEL);
	if (!q) {
		put_unused_fd(fd);
		put_filp(filp);
		return -ENOMEM;
	}

	/* Initialize queue structure */
	init_waitqueue_head(&q->waiters);
	filp->private_data = q;

	/* Go for it... */
	queue_me(head, q, page, offset, fd, filp);

	/* Now we map fd to filp, so userspace can access it */
	fd_install(fd, filp);
	return 0;
}

/* Oh yeah, makes sense to write a filesystem... */
static struct super_operations futexfs_ops = {
	statfs:		simple_statfs,
};

static int futexfs_fill_super(struct super_block *sb, void *data, int silent)
{
	struct inode *root;
	sb->s_blocksize = 1024;
	sb->s_blocksize_bits = 10;
	sb->s_magic = 0xFBAD1DEA;
	sb->s_op = &futexfs_ops;
	root = new_inode(sb);
	if (!root)
		return -ENOMEM;
	root->i_mode = S_IFDIR | S_IRUSR | S_IWUSR;
	root->i_uid = root->i_gid = 0;
	root->i_atime = root->i_mtime = root->i_ctime = CURRENT_TIME;
	sb->s_root = d_alloc(NULL, &(const struct qstr) { "futex", 5, 0 });
	if (!sb->s_root) {
		iput(root);
		return -ENOMEM;
	}
	sb->s_root->d_sb = sb;
	sb->s_root->d_parent = sb->s_root;
	d_instantiate(sb->s_root, root);
	return 0;
}

static struct super_block *
futexfs_get_sb(struct file_system_type *fs_type,
	       int flags, char *dev_name, void *data)
{
	return get_sb_nodev(fs_type, flags, data, futexfs_fill_super);
}

static struct file_system_type futex_fs_type = {
	name:		"futexfs",
	get_sb:		futexfs_get_sb,
	kill_sb:	kill_anon_super,
	fs_flags:	FS_NOMOUNT,
};

static int __init init(void)
{
	unsigned int i;
	struct qstr name = { .name = "futex", .len = 5, .hash = 0 };
	struct vfsmount *futex_mnt;

	register_filesystem(&futex_fs_type);
	futex_mnt = kern_mount(&futex_fs_type);
	futex_dentry = d_alloc(NULL, &name);
	futex_dentry->d_inode = new_inode(futex_mnt->mnt_sb);

	for (i = 0; i < ARRAY_SIZE(futex_queues); i++)
		INIT_LIST_HEAD(&futex_queues[i]);
	return 0;
}
__initcall(init);

-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
