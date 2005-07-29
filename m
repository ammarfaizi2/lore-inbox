Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262634AbVG2PsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262634AbVG2PsX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 11:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVG2PsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 11:48:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:31476 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262632AbVG2PsO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 11:48:14 -0400
Message-ID: <42EA4F9E.4070107@mvista.com>
Date: Fri, 29 Jul 2005 08:47:42 -0700
From: Mark Bellon <mbellon@mvista.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc3 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Kara <jack@suse.cz>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH]  disk quotas fail when /etc/mtab is symlinked to /proc/mounts
References: <42E97236.6080404@mvista.com> <20050729134643.GB3718@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20050729134643.GB3718@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara wrote:

>  Hello,
>
>  
>
>>If /etc/mtab is a regular file all of the mount options (of a file 
>>system) are written to /etc/mtab by the mount command. The quota tools 
>>look there for the quota strings for their operation. If, however, 
>>/etc/mtab is a symlink to /proc/mounts (a "good thing" in some 
>>environments)  the tools don't write anything - they assume the kernel 
>>will take care of things.
>>
>>While the quota options are sent down to the kernel via the mount system 
>>call and the file system codes handle them properly unfortunately there 
>>is no code to echo the quota strings into /proc/mounts and the quota 
>>tools fail in the symlink case.
>>    
>>
>  Yes, I agree that it's a good think to have quota options in
>/proc/mounts. Doing it per filesystem is not nice but I don't know a
>nice way of doing it a VFS level either...
>  
>
I'll have a new patch which includes your comments and a few I thought 
up soon. I'll repost the new patch.

mark

>  
>
>>The attached patchs modify the EXT[2|3] and [X|J]FS codes to add the 
>>necessary hooks. The show_options function of each file system in these 
>>patches currently deal with only those things that seemed related to 
>>quotas; especially in the EXT3 case more can be done (later?).
>>
>>The EXT3 has added error checking and has two minor changes:
>>   The "quota" option is considered part of the older style quotas
>>   Journalled quotas and older style quotas are mutually exclusive.
>>   - both discussable topics
>>    
>>
>  Ack.
>
>  
>
>>mark
>>
>>Signed-off-by: Mark Bellon <mbellon@mvista.com>
>>
>>    
>>
>  Thanks for the patch - I have some comments below...
>
>  <snip>
>  
>
>> #ifdef CONFIG_QUOTA
>>+static int ext3_show_options(struct seq_file *seq, struct vfsmount *vfs)
>>+{
>>+	struct ext3_sb_info *sbi = EXT3_SB(vfs->mnt_sb);
>>+
>>+	if (sbi->s_mount_opt & EXT3_MOUNT_JOURNAL_DATA)
>>+		seq_puts(seq, ",data=journal");
>>+
>>+	if (sbi->s_mount_opt & EXT3_MOUNT_ORDERED_DATA)
>>+		seq_puts(seq, ",data=ordered");
>>+
>>+	if (sbi->s_mount_opt & EXT3_MOUNT_WRITEBACK_DATA)
>>+		seq_puts(seq, ",data=writeback");
>>    
>>
>  Showing 'data' option only when quota is compile is ugly... Please move
>CONFIG_QUOTA inside only around quota specific stuff.
>
>  
>
>>+
>>+	if (sbi->s_jquota_fmt)
>>+		seq_printf(seq, ",jqfmt=%s",
>>+		(sbi->s_jquota_fmt == QFMT_VFS_OLD) ? "vfsold": "vfsv0");
>>+
>>+	if (sbi->s_qf_names[USRQUOTA])
>>+		seq_printf(seq, ",usrjquota=%s", sbi->s_qf_names[USRQUOTA]);
>>+
>>+	if (sbi->s_qf_names[GRPQUOTA])
>>+		seq_printf(seq, ",grpjquota=%s", sbi->s_qf_names[GRPQUOTA]);
>>+
>>+	if (sbi->s_mount_opt & EXT3_MOUNT_USRQUOTA)
>>+		seq_puts(seq, ",usrquota");
>>+
>>+	if (sbi->s_mount_opt & EXT3_MOUNT_GRPQUOTA)
>>+		seq_puts(seq, ",grpquota");
>>+
>>+	return 0;
>>+}
>> 
>> #define QTYPE2NAME(t) ((t)==USRQUOTA?"user":"group")
>> #define QTYPE2MOPT(on, t) ((t)==USRQUOTA?((on)##USRJQUOTA):((on)##GRPJQUOTA))
>>@@ -572,6 +604,7 @@
>> #ifdef CONFIG_QUOTA
>> 	.quota_read	= ext3_quota_read,
>> 	.quota_write	= ext3_quota_write,
>>+	.show_options	= ext3_show_options,
>>    
>>
>  Probably set this function everytime...
>
><snip>
>
>  
>
>>+		case Opt_quota:
>>+		case Opt_usrquota:
>>+		case Opt_grpquota:
>> 		case Opt_usrjquota:
>> 		case Opt_grpjquota:
>> 		case Opt_offusrjquota:
>>@@ -924,7 +973,6 @@
>> 				"EXT3-fs: journalled quota options not "
>> 				"supported.\n");
>> 			break;
>>-		case Opt_quota:
>> 		case Opt_noquota:
>> 			break;
>>    
>>
>  I'm not sure with the above change.. Previously if you mounted a
>filesystem with 'usrquota' option without a kernel quota support the mount
>succeeded. With your patch it will fail. I agree that that makes more
>sense but I'm not sure it's correct to change a behaviour so suddently.
>Maybe just issue a warning but let the mount succeed.
>
>  
>
>> #endif
>>@@ -962,11 +1010,36 @@
>> 		}
>> 	}
>> #ifdef CONFIG_QUOTA
>>-	if (!sbi->s_jquota_fmt && (sbi->s_qf_names[USRQUOTA] ||
>>-	    sbi->s_qf_names[GRPQUOTA])) {
>>-		printk(KERN_ERR
>>+	if (sbi->s_qf_names[USRQUOTA] || sbi->s_qf_names[GRPQUOTA]) {
>>+		if ((sbi->s_mount_opt & EXT3_MOUNT_USRQUOTA) || 
>>+		    (sbi->s_mount_opt & EXT3_MOUNT_GRPQUOTA)) {
>>+			printk(KERN_ERR
>>+			"EXT3-fs: only one type of quotas allowed.\n");
>>+
>>+			return 0;
>>+		}
>>+
>>+		if (!sbi->s_jquota_fmt) {
>>+			printk(KERN_ERR
>> 			"EXT3-fs: journalled quota format not specified.\n");
>>-		return 0;
>>+
>>+			return 0;
>>+		}
>>+
>>+		if ((sbi->s_mount_opt & EXT3_MOUNT_JOURNAL_DATA) == 0) {
>>    
>>
>  This test does not make sense - journaled quota in recent kernels
>works with arbitrary journaling data mode.
>
>  
>
>>+			printk(KERN_ERR
>>+	"EXT3-fs: journalled quota specified when data journalling is not.\n");
>>+
>>+			return 0;
>>+		}
>>+	}
>>+	else {
>>+		if (sbi->s_jquota_fmt) {
>>+			printk(KERN_ERR
>>+"EXT3-fs: journalled quota format specified with no journalling enabled.\n");
>>+
>>+			return 0;
>>+		}
>> 	}
>> #endif
>> 
>>+#if defined(CONFIG_QUOTA)
>>+		case Opt_usrquota:
>>+			set_opt(sbi->s_mount_opt, USRQUOTA);
>>+			break;
>>+
>>+		case Opt_grpquota:
>>+			set_opt(sbi->s_mount_opt, GRPQUOTA);
>>+			break;
>>+
>>+		case Opt_quota:
>>+			set_opt(sbi->s_mount_opt, GRPQUOTA);
>>+			set_opt(sbi->s_mount_opt, USRQUOTA);
>>+			break;
>>    
>>
>  The old 'quota' option means the same as 'usrquota' - at least tools
>consider it like that.
>
>  
>
>>+#else
>>+		case Opt_quota:
>>+		case Opt_usrquota:
>>+		case Opt_grpquota:
>>+			printk(KERN_ERR
>>+				"EXT2-fs: quota operations not supported.\n");
>>+
>>+			break;
>>+#endif
>>    
>>
>  The same as with ext3 - I don't like this change...
>
>  <snip>
>
>								Honza
>  
>

