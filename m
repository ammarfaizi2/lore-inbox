Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130940AbRCWPCt>; Fri, 23 Mar 2001 10:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131219AbRCWPCj>; Fri, 23 Mar 2001 10:02:39 -0500
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:2821 "HELO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with SMTP
	id <S130940AbRCWPC2>; Fri, 23 Mar 2001 10:02:28 -0500
Message-ID: <C50AB9511EE59B49B2A503CB7AE1ABD11043B8@cceexc19.americas.cpqcorp.net>
From: "Dupuis, Don" <Don.Dupuis@COMPAQ.com>
To: "'Tony.Young@ir.com'" <Tony.Young@ir.com>, linux-kernel@vger.kernel.org
Subject: RE: /proc/stat disk_io entries
Date: Fri, 23 Mar 2001 09:01:31 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have sent a patch to Alan and Linus about this also.  We have cpqarray and
cciss controllers that use major 72-79 and 104-111.  Alan said he doesn't
have time to look at it till mid April and Linus hasn't responded to me at
all about it.  The best way is to actually rewrite the kstat architecture,
but the patch I sent it will do the job.  There is concern about structure
table size I believe.  My patch increased DK_MAX_MAJOR to 112 and added
about 4 lines to genhd.h to support the cpqarray and cciss driver.  This
works on Compaq servers and I get the data that is needed.  Any thoughts?

-----Original Message-----
From: Tony.Young@ir.com [mailto:Tony.Young@ir.com]
Sent: Thursday, March 22, 2001 9:55 PM
To: linux-kernel@vger.kernel.org
Subject: /proc/stat disk_io entries


All,

Firstly, my relevant system stats:
	kernel	linux 2.4.3-pre6
	hda	IDE Drive
	hdb	CD drive
	hdc	IDE Drive
	hdd	IDE Drive
	sda	SCSI Drive

The problem I'm seeing is that IO stats (disk_io) aren't being shown in
/proc/stats for the 2 harddrives on the second ide controller (hdc and hdd).

I checked the kernel code and found the function kstat_read_proc in
fs/proc/proc_misc.c which loops through from 0 up to DK_MAX_MAJOR and prints
out the stats to /proc/stat for each drive. However, DK_MAX_MAJOR is set to
16 in include/linux/kernel_stat.h, which means that the drives on my second
ide controller, with a major number of 22, aren't included in the loop.

I modified the value of DK_MAX_MAJOR to 23 and rebuilt and /proc/stats now
shows the 2 missing harddrives. I'm uncomfortable sending in a patch for
this as I'm not familiar enough with the code to understand the full
ramifications of changing this value. Considering also that the value 23
stills doesn't include any tertiary or quaternary ide controllers (33 and
34) makes me wonder what the correct value should really be.

I'm also curious, after considering the above, about whether or not a hash
table(s) would be better suited to the current implementation of
2-dimensional arrays for disk stats (dk_drive, dk_drive_rio, dk_drive_wio,
etc).

I've brought this to the list because I'm not sure of the correct solution
and I couldn't work out if there was a specific maintainer of this code.

It also seems strange to me that the identifiers for the values for disk_io
in /proc/stat are (major_number,disk_number) tuples rather than
(major,minor). The current implementation with my change now shows my first
ide drive to be identified as (8,0), while my second and third ide drives
(hdc and hdd) are identified as (22,2) and (22,3) respectively rather than
(22,0) and (22,1) - I presume because they are the in the 3rd and 4th ide
positions. Using disk_number instead of minor number also makes it more
difficult for any user programs reading /proc/stat to trace the entry back
to a physical device. Any program must make assumptions that major numbers 8
and 22 refer to /dev/hd* entries, and that disk number 0 translates to 'a',
1 to 'b', 2 to 'c', etc and can then work out that 22,2 means /dev/hdc.
These assumption, of course, break with the use of devfs when not using
devfsd to provide the necessary links.

I welcome any comments, but please CC me directly as I'm not subscribed to
the list.

Tony...
--
Tony Young
Senior Software Engineer
Integrated Research Limited
Level 10, 168 Walker St
North Sydney, NSW 2060, Australia
Ph:  +61 2 9966 1066
Fax: +61 2 9966 1042
Mob: 0414 649942

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
