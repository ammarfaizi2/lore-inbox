Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311582AbSCXFja>; Sun, 24 Mar 2002 00:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311579AbSCXFjV>; Sun, 24 Mar 2002 00:39:21 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:16208 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S311577AbSCXFjE>; Sun, 24 Mar 2002 00:39:04 -0500
Date: Sun, 24 Mar 2002 00:38:58 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: Douglas Gilbert <dougg@torque.net>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Patch to split kmalloc in sd.c in 2.4.18+
Message-ID: <20020324003858.A27380@devserv.devel.redhat.com>
In-Reply-To: <20020322215809.A17173@devserv.devel.redhat.com> <3C9CB643.FC33C0AF@torque.net> <20020323143753.A1011@devserv.devel.redhat.com> <3C9D5219.1403288B@torque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Your patch worked ok for me. I have a couple of real
> disks and 120 simulated ones with scsi_debug. My last disk
> was /dev/sddq and I was able to fdisk, mke2fs, mount
> and copy files to it ok.

Great many thanks. I'll give it some time to settle and will ask
Alan or Marcelo to take it. BTW, the real test is not being able
to load modules and do stuff. The bad part is what happens when
you do a string of rmmod/modprobe in random order and with varying
parameters for scsi_debug (scsi_debug_num_devs=NN). Then it's going
to show if memory leaks or get corrupted. I certainly hope that
I did it right, but I was known to make mistakes before.

Another side note: towards the end of the patch, there is a reminder
about an entirely different issue that noted when doing the patch:

+               for (i = 0; i < N_USED_SD_MAJORS; i++) {
+#if 0 /* XXX aren't we forgetting to deallocate something? */
+                       kfree(sd_gendisks[i].de_arr);
+                       kfree(sd_gendisks[i].flags);
+#endif
+                       kfree(sd_gendisks[i].part);
+               }
        }
        for (i = 0; i < N_USED_SD_MAJORS; i++) {
                del_gendisk(&sd_gendisks[i]);
-               blk_size[SD_MAJOR(i)] = NULL;
+               blk_size[SD_MAJOR(i)] = NULL;   /* XXX blksize_size actually? */                hardsect_size[SD_MAJOR(i)] = NULL; 
                read_ahead[SD_MAJOR(i)] = 0;
        }

E.g. I do not see a place where .flags and .de_arr are freed; also,
I am not sure why we assign blksize_size[], but we zero blk_size[].
I do not want to mix this up with the split-allocation patch, but
it is curious. I think we leak memory on sd_mod unload here.

-- Pete
