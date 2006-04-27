Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWD0OOC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWD0OOC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 10:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbWD0OOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 10:14:01 -0400
Received: from host94-205.pool8022.interbusiness.it ([80.22.205.94]:28119 "EHLO
	waobagger.intranet.nucleus.it") by vger.kernel.org with ESMTP
	id S965126AbWD0OOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 10:14:00 -0400
From: Massimiliano Hofer <max@nucleus.it>
Organization: Nucleus snc
To: linux-kernel@vger.kernel.org
Subject: race in remove_proc_entry()
Date: Thu, 27 Apr 2006 16:13:37 +0200
User-Agent: KMail/1.9.1
X-Face: K`wgvx&HhZL9|Oz+ZIU$]O&CG5N(Zr(QXdPZhk~,S*XNK9.}0u`+=SwR|^2cW.{Ei}F'0(=?utf-8?q?=0A=09q?=>|]o"}A4'HvAe=!Q_W/t9']yG%RA'[j6iX8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604271613.38590.max@nucleus.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I found what I think is a nasty behaviour in procfs.

If I create a proc entry and rely on proc_file_read() and proc_file_write() to 
hand requests to dp->read_proc and dp->write_proc there is no protection from 
removal.

Example:
Process A            Process B
proc_file_read()
                     remove_proc_entry()
                     kfree(/* whatever was in dp->data */)
dp->read_proc()


read_proc() has no way to know if dp->data has been zeroed or freed since it 
was read by proc_file_read(). Process B has no way to know that a read is in 
progress.
Of course I can reimplement proc_file_read(), but this makes it pointless in 
the first place.
Most proc entries live as long as the kernel or the module that creates them, 
so this is a really rare problem, but there are simple precautions that could 
prevent it.

We could:
- add a per proc file lock (it could be optional);
- add an optional callback that allows us to perform whatever is needed when 
the file is really removed (remove_proc_entry() or de_put()).

The latter would be really simple and would allow for proper completion of 
read/write operations with whatever lock and protection is needed inside 
dp->data and possibly a simple kfree() performed by the disposal callback 
when everyone is really done.

-- 
Saluti,
   Massimiliano Hofer
        Nucleus
