Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264154AbUGBM4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264154AbUGBM4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 08:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUGBM4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 08:56:52 -0400
Received: from outmx009.isp.belgacom.be ([195.238.3.4]:35712 "EHLO
	outmx009.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264154AbUGBM4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 08:56:35 -0400
Subject: Re: Block Device Caching
From: FabF <fabian.frederick@skynet.be>
To: Markus Schaber <schabios@logi-track.com>
Cc: Helge Hafting <helge.hafting@hist.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040702140144.43088dc2@kingfisher.intern.logi-track.com>
References: <20040630002014.4970b82d@kingfisher.intern.logi-track.com>
	 <40E1FDEC.6020606@techsource.com> <40E279F4.4090708@hist.no>
	 <20040630123828.7d48c6e6@kingfisher.intern.logi-track.com>
	 <40E543D7.9030303@hist.no>
	 <20040702140144.43088dc2@kingfisher.intern.logi-track.com>
Content-Type: text/plain
Message-Id: <1088772969.3643.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 02 Jul 2004 14:56:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-02 at 14:01, Markus Schaber wrote:
> Hi, Helge,
> 
> On Fri, 02 Jul 2004 13:15:35 +0200
> Helge Hafting <helge.hafting@hist.no> wrote:
> > > [Caching problems]
> > >Any Ideas?
> > >
> > Not much.  "bear" may have decided to drop cache in one case but not
> > in the other - that is valid although strange.  Take a look at what
> > block size the device uses.  A mounted device uses the fs blocksize, a
> > partition(or entire disk) may be set to some different blocksize.  (I
> > believe it might be the classical 512 byte) Caching blocks
> > with a size different from the page size (usually 4k) has extra
> > overhead and could lead to extra memory pressure and different caching
> > decisions.
> >
> > So I recommend retesting bear with a good blocksize, such as 4k, on
> > the device.  That also gives somewhat better performance in general
> > than 512-byte blocks.  There is a syscall for changing the block size
> > of a device.
> > 
> > (Block size may also be changed by the following hack:  mount a fs
> > like ext2 on the device, then umount it.  Of course you need to use
> > mkfs so this can't be done on a device that contains data.
> > "mount" sets the device block size to the size used by the fs.
> > After umount, the device is free to be opened directly again, but it
> > retains the new blocksize.)
> 
> This sounds reasonable, and so I did some tests wr/t mounting and memory
> pressure:
> 
> 
> bear:~/readcachetest# top | head -n 8 | tail -n 2
> Mem:   3953624k total,   775776k used,  3177848k free,   458060k buffers
> Swap:  1048568k total,        0k used,  1048568k free,    31812k cached
> 
> bear:~/readcachetest# ./readcache /dev/daten/testing 1000
> frist run needed 12.374819 seconds, this is 80.809263 MBytes/Sec
> second run needed 12.004670 seconds, this is 83.300915 MBytes/Sec
> third run needed 11.898035 seconds, this is 84.047492 MBytes/Sec
> 
> bear:~/readcachetest# top | head -n 8 | tail -n 2
> Mem:   3953624k total,   775648k used,  3177976k free,   457904k buffers
> Swap:  1048568k total,        0k used,  1048568k free,    31900k cached
> 
> bear:~/readcachetest# mount /dev/daten/testing /testinmount/ -t ext2
> 
> bear:~/readcachetest# top | head -n 8 | tail -n 2
> Mem:   3953624k total,   775720k used,  3177904k free,   457944k buffers
> Swap:  1048568k total,        0k used,  1048568k free,    31860k cached
> 
> bear:~/readcachetest# ./readcache /dev/daten/testing 1000
> frist run needed 12.199237 seconds, this is 81.972340 MBytes/Sec
> second run needed 12.028633 seconds, this is 83.134966 MBytes/Sec
> third run needed 12.454502 seconds, this is 80.292251 MBytes/Sec
> 
> bear:~/readcachetest# top | head -n 8 | tail -n 2
> Mem:   3953624k total,  1125432k used,  2828192k free,   808008k buffers
> Swap:  1048568k total,        0k used,  1048568k free,    31792k cached
> 
> bear:~/readcachetest# ./readcache /testinmount/test.dump 1000
> frist run needed 11.985626 seconds, this is 83.433272 MBytes/Sec
> second run needed 3.682361 seconds, this is 271.564901 MBytes/Sec
> third run needed 3.638563 seconds, this is 274.833774 MBytes/Sec
> 
> bear:~/readcachetest# top | head -n 8 | tail -n 2
> Mem:   3953624k total,  2150128k used,  1803496k free,   808736k buffers
> Swap:  1048568k total,        0k used,  1048568k free,  1055688k cached
> 
> bear:~/readcachetest# ./readcache /dev/daten/testing 1000
> frist run needed 12.418232 seconds, this is 80.526761 MBytes/Sec
> second run needed 12.381597 seconds, this is 80.765026 MBytes/Sec
> third run needed 12.185159 seconds, this is 82.067046 MBytes/Sec
> 
> bear:~/readcachetest# top | head -n 8 | tail -n 2
> Mem:   3953624k total,  2149232k used,  1804392k free,   807784k buffers
> Swap:  1048568k total,        0k used,  1048568k free,  1055756k cached
> 
> bear:~/readcachetest# umount /testinmount/
> 
> bear:~/readcachetest# top | head -n 8 | tail -n 2
> Mem:   3953624k total,   775728k used,  3177896k free,   457872k buffers
> Swap:  1048568k total,        0k used,  1048568k free,    31728k cached
> 
> bear:~/readcachetest# ./readcache /dev/daten/testing 1000
> frist run needed 12.171772 seconds, this is 82.157306 MBytes/Sec
> second run needed 11.842943 seconds, this is 84.438471 MBytes/Sec
> third run needed 12.167059 seconds, this is 82.189131 MBytes/Sec
> 
> bear:~/readcachetest# top | head -n 8 | tail -n 2
> Mem:   3953624k total,   775656k used,  3177968k free,   457876k buffers
> Swap:  1048568k total,        0k used,  1048568k free,    31860k cached
> 
> So files from the mounted fs get cached, but not direct reads from the
> block device, although the lvm volume is mounted, and enough memory is
> available.
> 
> I currently suspect this to be a problem with the cciss controller, see
> my other mail to the list...
> 
> > You may also want to test with a smaller count.  Reading directly from
> > pagecache should be noticeably faster than reading from the cache on
> > the raid controller, although either obviously is way faster than
> > reading from actual disks.
> 
> bear:~/readcachetest# ./readcache /dev/daten/testing 100 
> frist run needed 1.202330 seconds, this is 83.171841 MBytes/Sec
> second run needed 0.349686 seconds, this is 285.970842 MBytes/Sec
> third run needed 0.346644 seconds, this is 288.480401 MBytes/Sec
> 
> bear:~/readcachetest# mount /dev/daten/testing /testinmount/ -t ext2
> 
> bear:~/readcachetest# ./readcache /testinmount/test.dump 100 
> frist run needed 1.205797 seconds, this is 82.932699 MBytes/Sec
> second run needed 0.367004 seconds, this is 272.476594 MBytes/Sec
> third run needed 0.362783 seconds, this is 275.646874 MBytes/Sec
> 
> bear:~/readcachetest# ./readcache /testinmount/test.dump 100
> frist run needed 0.363097 seconds, this is 275.408500 MBytes/Sec
> second run needed 0.363002 seconds, this is 275.480576 MBytes/Sec
> third run needed 0.362852 seconds, this is 275.594457 MBytes/Sec
> 
> bear:~/readcachetest# umount /testinmount/
> 
> bear:~/readcachetest# mount /dev/daten/testing /testinmount/ -t ext2
> 
> bear:~/readcachetest# ./readcache /testinmount/test.dump 100
> frist run needed 1.189227 seconds, this is 84.088235 MBytes/Sec
> second run needed 0.367456 seconds, this is 272.141426 MBytes/Sec
> third run needed 0.363139 seconds, this is 275.376646 MBytes/Sec
> 
> Hmm, I'm somehow irritated now, as 275 MB/Sec seems rather low for reads
> from the page cache on a 2.8Ghz Xeon machine (even my laptop gets about 400
> MB/Sec with this, and Skate even reaches 3486.385664 MBytes/Sec.)
> 
> 
> No idea...
> Markus.
Did you played with hdparm -m <device> ?

Regards,
FabF

