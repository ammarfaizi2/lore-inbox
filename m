Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291883AbSBARvR>; Fri, 1 Feb 2002 12:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291886AbSBARvJ>; Fri, 1 Feb 2002 12:51:09 -0500
Received: from office.mandrakesoft.com ([195.68.114.34]:44782 "EHLO
	office.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S291883AbSBARu5>; Fri, 1 Feb 2002 12:50:57 -0500
To: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fixes supermount Oopses when mount options are not given
In-Reply-To: <20020201174507.GA1860@rayden.distro.conectiva>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20020201174507.GA1860@rayden.distro.conectiva>
Date: 01 Feb 2002 18:41:18 +0100
Message-ID: <m2665h3xs1.fsf@localhost.mandrakesoft.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "eduardo" == Eduardo Pereira Habkost <ehabkost@conectiva.com.br> writes:

eduardo> The following patch fixes two Oopses on supermount.
eduardo> The first one happens when the dev= option is not given to supermount, iput()
eduardo> is called after dput(), but iput() is already called by dput().
eduardo> The other one happens when the fs= option is not given. subfs_mount() doesn't
eduardo> check if sbi->s_type is NULL.

eduardo> Regards,

eduardo> --
eduardo> Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
eduardo> http://www.boto.f2s.com
eduardo> 04BE D2EF 5A56 E446 D424  4785 71A4 49EB AC35 9568
eduardo> ----

eduardo> # ------------------------
eduardo> diff -urN kernel-2.4.17/linux/fs/supermount/super.c kernel-2.4.17-supermountok/linux/fs/supermount/super.c
eduardo> --- kernel-2.4.17/linux/fs/supermount/super.c	Fri Feb  1 14:10:39 2002
eduardo> +++ kernel-2.4.17-supermountok/linux/fs/supermount/super.c	Fri Feb  1 11:56:36 2002
eduardo> @@ -276,7 +276,7 @@
eduardo> char **type = types_in_order;
 
 
eduardo> -	if (strcmp(sbi->s_type, "auto"))
eduardo> +	if (sbi->s_type && strcmp(sbi->s_type, "auto"))
eduardo> return subfs_real_mount2 (sb, sbi->s_type);
 		
eduardo> while (*type && retval) {
eduardo> diff -urN kernel-2.4.17/linux/fs/supermount/super_operations.c kernel-2.4.17-supermountok/linux/fs/supermount/super_operations.c
eduardo> --- kernel-2.4.17/linux/fs/supermount/super_operations.c	Fri Feb  1 14:10:39 2002
eduardo> +++ kernel-2.4.17-supermountok/linux/fs/supermount/super_operations.c	Fri Feb  1 11:56:36 2002
eduardo> @@ -279,10 +279,12 @@
eduardo> return s;
eduardo> fail_parsing:
s-> s_dev = 0;
eduardo> -	dput (root);
eduardo> fail_allocating_root:
eduardo> supermount_debug ("get root dentry failed");
eduardo> -	iput (root_inode);
eduardo> +	if(root)
eduardo> +		dput (root);
eduardo> +	else
eduardo> +		iput (root_inode);
eduardo> free_sbi (sbi);
eduardo> fail_no_memory:
eduardo> return NULL;

THanks a lot.

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
