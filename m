Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVESDNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVESDNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 23:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbVESDNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 23:13:55 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40940 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262459AbVESDNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 23:13:44 -0400
Subject: Re: why nfs server delay 10ms in nfsd_write()?
From: Lee Revell <rlrevell@joe-job.com>
To: steve <lingxiang@huawei.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "zhangtiger@huawei.com" <zhangtiger@huawei.com>
In-Reply-To: <0IGP00IZRULADZ@szxml02-in.huawei.com>
References: <0IGP00IZRULADZ@szxml02-in.huawei.com>
Content-Type: text/plain
Date: Wed, 18 May 2005 23:13:43 -0400
Message-Id: <1116472423.11327.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 10:46 +0800, steve wrote:
> i have 2 questions:
> 1.i don't know why do we have to sleep for 10 ms, why not do sync immediately?
> 2.what will happen if we don't sleep for 10ms?
> when i delete these codes, i get a good result, and the write performace improved from 300KB/s to 18MB/s
> 

Did you read the comments in the code?

                /*
                 * Gathered writes: If another process is currently
                 * writing to the file, there's a high chance
                 * this is another nfsd (triggered by a bulk write
                 * from a client's biod). Rather than syncing the
                 * file with each write request, we sleep for 10 msec.
                 *
                 * I don't know if this roughly approximates
                 * C. Juszak's idea of gathered writes, but it's a
                 * nice and simple solution (IMHO), and it seems to
                 * work:-)
                 */
                if (EX_WGATHER(exp)) {
                        if (atomic_read(&inode->i_writecount) > 1
                            || (last_ino == inode->i_ino && last_dev == inode->i_sb->s_dev)) {
                                dprintk("nfsd: write defer %d\n", current->pid);
                                msleep(10);
                                dprintk("nfsd: write resume %d\n", current->pid);
                        }       

                        if (inode->i_state & I_DIRTY) {
                                dprintk("nfsd: write sync %d\n", current->pid);
                                nfsd_sync(file);
                        }       
#if 0
                        wake_up(&inode->i_wait);
#endif
                }


Lee

