Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132650AbQL1Xe6>; Thu, 28 Dec 2000 18:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132689AbQL1Xes>; Thu, 28 Dec 2000 18:34:48 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:61962 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132650AbQL1Xeh>; Thu, 28 Dec 2000 18:34:37 -0500
Date: Thu, 28 Dec 2000 16:59:48 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: 2.2.19 hard hang from userspace while accessing /dev/mdXX devices
Message-ID: <20001228165948.A22926@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hard hand in 2.2.19

If you open a non-existant md device (i.e. /dev/md11) from userspace 
with an open() call, then send an ioctl() command, it results in the
following message then hard hangs the entire system if you attempt
to open any /dev/mdXX device with a minor number greater than 10.  
Used to work on 2.2.17.

message is:

md map 11
bap map 11 ll_rw_block
       

offending code that causes the hard hang is:


        register int fd, ccode;
        struct hd_geometry geometry;

        fd = open("/dev/md11", O_RDWR);
        if (fd < 0)
            return 1;

#ifdef HDIO_REQ
       ccode = ioctl(fd, HDIO_REQ, &geometry);
#else
       ccode = ioctl(fd, HDIO_GETGEO, &geometry);
#endif
       if ((ccode == -EINVAL) || (ccode == -ENODEV))
       {
          close(fd);
          return 1;
       }  
       close(fd)
       return 0;


Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
