Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbSK2Gwd>; Fri, 29 Nov 2002 01:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266970AbSK2Gwd>; Fri, 29 Nov 2002 01:52:33 -0500
Received: from [211.101.140.97] ([211.101.140.97]:26129 "EHLO
	dns.rabbit.redflag-linux.com") by vger.kernel.org with ESMTP
	id <S266969AbSK2Gwc> convert rfc822-to-8bit; Fri, 29 Nov 2002 01:52:32 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Zou Pengcheng <pczou@redflag-linux.com>
Organization: RedFlag Linux
To: linux-kernel@vger.kernel.org
Subject: writev/readv dnotify confusion
Date: Fri, 29 Nov 2002 14:58:12 +0800
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211291458.12893.pczou@redflag-linux.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

not sure if dnotify is handled by writev/readv correctly,

below are some code of do_readv_writev() in linux/fs/read_write.c:

out_nofree:
        /* VERIFY_WRITE actually means a read, as we write to user space */
        if ((ret + (type == VERIFY_WRITE)) > 0)
                dnotify_parent(file->f_dentry,
                        (type == VERIFY_WRITE) ? DN_MODIFY : DN_ACCESS);
        return ret;
}

based on this code, it seems writev() sets DN_ACCESS while readv() sets 
DN_MODIFY.

i have also verified this by writing a testing program, in my testing program,
if just do fcntl(fd, F_NOTIFY, DN_MODIFY), on signal is raised after a 
writev(),  if i do fcntl(fd, F_NOTIFY, DN_ACCESS), then get the signal.

so wonder maybe the code above should be modified as something like:

out_nofree:
        /* VERIFY_WRITE actually means a read, as we write to user space */
        if ((ret + (type == VERIFY_WRITE)) > 0)
                dnotify_parent(file->f_dentry,
                        (type == VERIFY_WRITE) ? DN_ACCESS : DN_MODIFY);
        return ret;
}

cheers,
