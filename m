Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262407AbTEIJPA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 05:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbTEIJPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 05:15:00 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:39601 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262407AbTEIJO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 05:14:58 -0400
Message-ID: <XFMail.20030509112703.R.Oehler@GDAmbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="_=XFMail.1.5.0.Linux:20030509112703:13450=_";
 micalg=pgp-md5; protocol="application/pgp-signature"
Date: Fri, 09 May 2003 11:27:03 +0200 (MEST)
From: Ralf Oehler <R.Oehler@GDAmbH.com>
To: linux-kernel@vger.kernel.org
Subject: missing get_empty_inode()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format
--_=XFMail.1.5.0.Linux:20030509112703:13450=_
Content-Type: text/plain; charset=iso-8859-1

Hello, list

Currently I'm porting my driver sources from 2.4.18 to 2.4.20 an I noticed
the absence of get_empty_inode().
I didn't find an exported function to get a sb-less inode.
My goal is to open sd- and an sg- devices in order to do
ioctl(send_scsi_cmd) on them. As my driver acts as a block device driver
(layered pseudo block device), there is no sb assigned to it.

What is, according to the current philosophy, the cleanest code-sniplet to

- open
- ioctl
- close

an sd-device ?
an sg-device ?

Currently (2.4.18), I do it like



open-sd:
        dummy_inode = get_empty_inode();
        init_special_inode( dummy_inode, 
                            S_IFBLK | 0600,
                            kdev );
        dummy_inode->i_bdev = bdev;
        dummy_inode->i_dev = dummy_inode->i_rdev;
        insert_inode_hash(dummy_inode);

close-sd:
        def_blk_fops.release(dummy_inode, &dummy_filp);

ioctl-sd:
        ioctl_by_bdev(dummy_inode->i_bdev, cmd, arg);




open-sg:
  dummy_inode = get_empty_inode();
  init_special_inode( dummy_inode, 
                      S_IFCHR | 0600,
                      kdev );
  dummy_inode->i_dev = dummy_inode->i_rdev;
  dummy_dentry.d_inode = dummy_inode;
  ret = init_private_file( dummy_file,
                           dummy_dentry,
                           FMODE_READ|FMODE_WRITE );    /* calls open() */
  insert_inode_hash(dummy_inode);

close-sg:
  dummy_file->f_op->release(dummy_inode, dummy_file);
  fops_put(filp->f_op);
  filp->f_dentry = NULL;
  dummy_inode->i_state |= I_FREEING;
  clear_inode(dummy_inode);
  dummy_inode = NULL;

ioctl-sg:
        filp->f_op->ioctl( dummy_inode, filp, cmd, arg );





Regards,
        Ralf


--
 --------------------------------------------------------------------------
|  Ralf Oehler                          
|                                       
|  GDA - Gesellschaft fuer Digitale                              _/
|        Archivierungstechnik mbH & CoKG                        _/
|  Ein Unternehmen der Bechtle AG               #/_/_/_/ _/_/_/_/ _/_/_/_/
|                                              _/    _/ _/    _/       _/
|  E-Mail:      R.Oehler@GDAmbH.com           _/    _/ _/    _/ _/    _/
|  Tel.:        +49 6182-9271-23             _/_/_/_/ _/_/_/#/ _/_/_/#/
|  Fax.:        +49 6182-25035                    _/
|  Mail:        GDA, Bensbruchstraﬂe 11,   _/_/_/_/
|               D-63533 Mainhausen      
|  HTTP:        www.GDAmbH.com         
 --------------------------------------------------------------------------

time is a funny concept









--_=XFMail.1.5.0.Linux:20030509112703:13450=_
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+u3RmxdAnPawJED4RAjUuAJ9rZyinuMQRrI0PV05LFI+E7U2PgwCdG1wE
mAhzbI9s1ptg4d3ZWzDNDCk=
=yphs
-----END PGP SIGNATURE-----

--_=XFMail.1.5.0.Linux:20030509112703:13450=_--
End of MIME message
