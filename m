Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131340AbRCHMaw>; Thu, 8 Mar 2001 07:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131347AbRCHMac>; Thu, 8 Mar 2001 07:30:32 -0500
Received: from mail.inup.com ([194.250.46.226]:17168 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S131340AbRCHMa2>;
	Thu, 8 Mar 2001 07:30:28 -0500
Date: Thu, 8 Mar 2001 13:30:31 +0100
From: christophe barbe <christophe.barbe@lineo.fr>
To: linux-kernel@vger.kernel.org
Subject: scan directory content in kernel-level code
Message-ID: <20010308133031.A21034@pc8.inup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to scan the content of the /dev directory in a init_module function.
I've not found example in the kernel source. So I try to reproduce the work of the system call.
I open the directory, check if the readdir pointer is not null in the f_op structure and then use it with my filldir function.
Because I don't need to stock names, I use filename directly in the filldir callback.
So in the filldir function, I check if the name match a simple regexp and if yes, I open the file and store the filp pointer.

First I don't understand why I need to call several times readdir in order to scan the directory (I imagine each times I obtain the content of one buffer). I check the number of callback call to stop calling readdir. It works but it seems strange.

Second problem, Sometimes the modprobe dead-locks in my filldir function. And I've found that it never arrives if i do a "ls /dev" before modprobe. Moreover if I don't take the directory inode semaphore, the problem never arrives. 
What's wrong ?

Christophe ...


struct my_dentry {
	char fullname[5];
	char name[MAX_DEVNAME_SIZE+1];
	int count;
};

int my_filldir(void * __buf, const char * name, int namlen, off_t offset, ino_t ino, unsigned unused)
{
	struct my_dentry * buf = (struct my_dentry *)__buf;

	if (namlen>MAX_DEVNAME_SIZE) namlen=MAX_DEVNAME_SIZE;

	memcpy((char *)buf->name, name, namlen);
	buf->name[namlen]='\0';
	check_device(buf->fullname);  // here I open the file if the string match criteria
	buf->count++;
	return 0;
}

void scan_device_directory(void)
{
	struct file * filp;
	struct inode * d_inode;
	struct my_dentry dir_entry={"/dev/",};
	int rc;

	filp = filp_open("/dev", O_RDONLY|O_SYNC, 0600);
	if ((rc=IS_ERR(filp))>0)  {
		printk("bad filp : %d\n", rc);
		return;
	}

	d_inode = filp->f_dentry->d_inode;
	if (!d_inode) {
		printk("NULL inode\n");
		goto out_close_dir;
	}

	if (! S_ISDIR(d_inode->i_mode)) {
		printk("/dev is not a directory (?)\n");
		goto out_close_dir;
	}

	if (filp->f_op->readdir == NULL) {
		printk("can't find readidir f_ops\n");
		goto out_close_dir;
	}

	v_printk("/dev : inode=%ld\n", d_inode->i_ino);

	down(&d_inode->i_sem);

	do {
		dir_entry.count=0;
		rc=filp->f_op->readdir(filp, (void *)&dir_entry, my_filldir);
	} while (dir_entry.count>0);

	up(&d_inode->i_sem);

out_close_dir:
	fput(filp);
}

-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
