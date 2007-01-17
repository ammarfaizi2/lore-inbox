Return-Path: <linux-kernel-owner+w=401wt.eu-S932252AbXAQKYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbXAQKYM (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 05:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbXAQKYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 05:24:12 -0500
Received: from ara.aytolacoruna.es ([195.55.102.196]:54645 "EHLO
	mx.aytolacoruna.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252AbXAQKYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 05:24:11 -0500
X-Greylist: delayed 1405 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Jan 2007 05:24:11 EST
Date: Wed, 17 Jan 2007 11:00:30 +0100
From: Santiago Garcia Mantinan <manty@debian.org>
To: linux-kernel@vger.kernel.org, debian-kernel@lists.debian.org
Subject: problems with latest smbfs changes on 2.4.34 and security backports
Message-ID: <20070117100030.GA11251@clandestino.aytolacoruna.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have discovered a problem with the changes applied to smbfs in 2.4.34 and
in the security backports like last Debian's 2.4 kernel update these changes
seem to be made to solve CVE-2006-5871 and they have broken symbolic links
and changed the way that special files (like devices) are seen.

For example:
Before: symbolic links were seen as that, symbolic links an thus if you tried
to open the file the link was followed and you ended up reading the
destination file
Now: symbolic links are seen as normal files (at least with a ls) but their
length (N) is the length of the symbolic link, if you read it, you'll get the
first N characters of the destination file. For example, on my filesystem
bin/sh is a symlink to bash, thus it is 4 bytes long, if I to a cat bin/sh I
get ELF (this is, the first 4 characters of the bash program, first one
being a DEL).

Another example:
Before: if you did a ls of a device file, like dev/zero you could see it as
a device, if you tried opening it, it wouldn't work, but if you did a cp -a
of that file to a local filesystem the result was a working zero device.
Now: the devices are seen as normal files with a length of 0 bytes.

Seems to me like a mask is erasing some mode bits that shouldn't be erased.

I have carried my tests on a Debian Sarge machine always mounting the share
using: smbmount //server/share /mnt without any other options. The tests
were carried on a unpatched 2.4.34 comparing it to 2.4.33 and also on
Debian's 2.4.27 comparing 2.4.27-10sarge4 vs -10sarge5. The server is a
samba 3.0.23d and I have experienced the same behaviour with samba's
unix extensions = yes and unix extensions = no.

I don't know what else to add, if you need any more info or want me to do
any tests just ask for it.

Regards...
-- 
Santiago García Mantiñán
