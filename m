Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030462AbWJ3AB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030462AbWJ3AB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 19:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030470AbWJ3AB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 19:01:27 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:24528 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030464AbWJ3AB0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 19:01:26 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: kvm-devel@lists.sourceforge.net
Subject: Re: [kvm-devel] [PATCH][RFC] KVM: prepare user interface for smp guests
Date: Mon, 30 Oct 2006 01:01:10 +0100
User-Agent: KMail/1.9.5
Cc: Avi Kivity <avi@qumranet.com>, linux-kernel <linux-kernel@vger.kernel.org>
References: <4544AD24.4040801@qumranet.com>
In-Reply-To: <4544AD24.4040801@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610300101.11245.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 October 2006 14:31, Avi Kivity wrote:
> +       r = -EEXIST;
> +       if (vcpu->vmcs)
> +               goto out_unlock;
> +
> +       r = -ENOMEM;
> +       filp = get_empty_filp();
> +       if (!filp)
> +               goto out_unlock;
> +
> +       r = get_unused_fd();
> +       if (r < 0)
> +               goto out_free_filp;
> +
> +       fd = r;
>  
>         vcpu->host_fx_image = (char*)ALIGN((hva_t)vcpu->fx_buf,
>                                            FX_IMAGE_ALIGN);
> @@ -1372,10 +1428,25 @@ static int kvm_dev_ioctl_create_vcpu(str
>         if (r < 0)
>                 goto out_free_vcpus;
>  
> -       return 0;
> +       filp->f_dentry = dget(kvm_filp->f_dentry);
> +       filp->f_vfsmnt = mntget(kvm_filp->f_vfsmnt);
> +       filp->f_mode = kvm_filp->f_mode;
> +       allow_write_access(filp);
> +       cdev_get(filp->f_dentry->d_inode->i_cdev);
> +       kvm_get(kvm);
> +       filp->f_op = fops_get(&kvm_vcpu_ops);
> +       filp->private_data = vcpu;
> +       fd_install(fd, filp);

Separating the objects into different file descriptors sounds like a
good idea, but reusing an open dentry/inode with a new file and different
file operations is a rather unusual way to do it. Your concept of allocating
a new context on each open is already weird, but there have been other
examples of that before.

I'd suggest going to a syscall-based model with your own file system right
away, even if you don't use the spufs approach but something in the middle:

* You do a trivial nonmountable new file system with anonymous objects,
  similar to eventpollfs, and hand out file descriptors to inodes in it,
  for both the kvm and the vcpu objects.
* You replace the syscall you'd normally use to hand out a new kvm instance
  with an ioctl on /dev/kvm, and don't allow any other operations on that
  device.

This would be a much more consistant object model, compared with other
generic kernel functionality that is not bound to an actual device.
You still have all the flexibility of a loadable module without core
kernel changes for the development phase, and can easily switch to real
syscalls when merging it into mainline.

I really think that a small number of syscalls is where you should be
heading, whether you use a file system or not, but I understand that
ioctls are convenient for development.

	Arnd <><
