Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286261AbSAANjD>; Tue, 1 Jan 2002 08:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286267AbSAANix>; Tue, 1 Jan 2002 08:38:53 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:31415 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S286261AbSAANig>; Tue, 1 Jan 2002 08:38:36 -0500
Date: Tue, 1 Jan 2002 15:28:02 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Cc: sak@iki.fi, phillips@innominate.de, viro@math.psu.edu,
        alan@lxorguk.ukuu.org.uk, tao@acc.umu.se
Subject: Ext2 groups descriptor corruption in 2.2 - Phillips's patch seems to work
Message-ID: <20020101152802.A1331@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago Daniel Phillips posted a patch for 2.4.0-test11 to cure groups
descriptor corruption in ext2.

The corruption had been seen with 2.2 and 2.0 for a long time. It happens
most likely in situations where there are many hard links to same inode (see
first report below).

I gather this fix has gone into 2.4 mainline in different form (see Al
Viro's fix below). It never went to 2.2 (nor 2.0) afaik.

The fix applies pretty cleanly to 2.2.20, and has been tested by me and
Samuli Kärkkäinen (again, see first problem report) for about a month now.
Samuli reports that he had been able to reproduce the bug in about 10-15
backup runs with unpatched 2.2.18. With the patch applied, it hasn't
appeared in well over 20 runs. My experience is similar with 2.2.20.

I haven't tested the patch on 2.0, but the problem seems to exists in 2.0 as
well. Taking a quick look, it seems the patch can be applied to 2.0.40pre3
with minor tweaking (s/ext2_get_group_desc/get_group_desc/g, remove
le16_to_cpu() from patch, and perhaps the add the additional get_group_desc
return value error checking to 2.0 ialloc.c that 2.2 has.)

Alan, David, perhaps this would be worth applying to next 2.2/2.0 pre? Al,
Daniel, what do you think? Should the patch be tidied up before 2.2
inclusion (as was done for 2.4)?

Daniel Phillips's patch (2000-11-30 0:03:37):
 http://marc.theaimsgroup.com/?l=linux-kernel&m=97554270404066&w=2

To which Al Viro replied (2000-11-30 0:33:30):
 http://marc.theaimsgroup.com/?l=linux-kernel&m=97554444306920&w=2
"Yes, it is. Moreover, correct solution is slightly different and changes                        
ext2_get_group_desc() semantics. Wait until tomorrow, OK?"

Al Viro's fix (2000-11-30 22:13:27):
 http://marc.theaimsgroup.com/?l=linux-kernel&m=97562262616388&w=2
"search for appropriate cylinder group had been taken out of the                       
 ext2_new_inode() into helper functions - find_cg_dir(sb, parent_group) and                      
 find_cg_other(sb, parent_group). Bug caught by Daniel (wrong bh being                           
 dirtied when we update the free inodes counter) - fixed."


Some corruption reports:
http://marc.theaimsgroup.com/?l=linux-kernel&m=98882213127507&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=99730849009286&w=2
http://www.linuxsa.org.au/mailing-list/2000-04/309.html
http://groups.google.com/groups?q=ext2_new_inode:+Free+inodes+count+corrupted+in+group&hl=en&rnum=1&selm=734g9b%24dkd%241%40coranto.ucs.mun.ca
http://groups.google.com/groups?q=ext2_check_inodes_bitmap:+Wrong+free+inodes+count&start=20&hl=en&rnum=21&selm=linux.kernel.20000707120824.26346.qmail%40yusufg.portal2.com

 
-- v --

v@iki.fi
