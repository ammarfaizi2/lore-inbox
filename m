Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbTJFSUF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTJFSUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:20:05 -0400
Received: from d12lmsgate-3.de.ibm.com ([194.196.100.236]:6026 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S263176AbTJFST4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:19:56 -0400
Importance: Normal
MIME-Version: 1.0
Sensitivity: 
To: Greg KH <greg@kroah.com>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       dipankar@in.ibm.com
Subject: Re: [RFC 0/6] Backing Store for sysfs
X-Mailer: Lotus Notes Release 5.0.12   February 13, 2003
From: "Christian Borntraeger" <CBORNTRA@de.ibm.com>
Message-ID: <OFE5D34FF9.74E7636D-ONC1256DB7.006373F4-C1256DB7.0064A9F8@de.ibm.com>
Date: Mon, 6 Oct 2003 20:19:32 +0200
X-MIMETrack: Serialize by Router on D12ML020/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/10/2003 20:19:33,
	Serialize complete at 06/10/2003 20:19:33
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I just did a test run. There is still more free memory than with a stock 
kernel. I guess some cache entries aged dropped out of existence.
I guess more cache entries will be removed if I put memory pressure on the 
system.
Please correct me, if I am wrong, but sysfs dentry and inode caches are 
currently unswappable, right?
But now to the results:


------standard after boot----------
cat /proc/meminfo 
MemTotal:       795612 kB 
MemFree:        175904 kB 
Buffers:          2620 kB 
Cached:         257948 kB 
SwapCached:          0 kB 
Active:          11280 kB 
Inactive:       251392 kB 
HighTotal:           0 kB 
HighFree:            0 kB 
LowTotal:       795612 kB 
LowFree:        175904 kB 
SwapTotal:     1355416 kB 
SwapFree:      1355416 kB 
Dirty:            1044 kB 
Writeback:           0 kB 
Mapped:           5032 kB 
Slab:           346220 kB 
Committed_AS:     4580 kB 
PageTables:        140 kB 
VmallocTotal: 4294139904 kB 
VmallocUsed:      2108 kB 
VmallocChunk: 4294137796 kB 



------with patch after boot-----------
cat /proc/meminfo 
MemTotal:       795612 kB 
MemFree:        702416 kB 
Buffers:          2604 kB 
Cached:          17328 kB 
SwapCached:          0 kB 
Active:          11040 kB 
Inactive:        11080 kB 
HighTotal:           0 kB 
HighFree:            0 kB 
LowTotal:       795612 kB 
LowFree:        702416 kB 
SwapTotal:     1355416 kB 
SwapFree:      1355416 kB 
Dirty:            1040 kB 
Writeback:           0 kB 
Mapped:           5016 kB 
Slab:            61004 kB 
Committed_AS:     4580 kB 
PageTables:        136 kB 
VmallocTotal: 4294139904 kB 
VmallocUsed:      1308 kB 
VmallocChunk: 4294138596 kB 

------with patch after find /sys-----------
cat /proc/meminfo 
MemTotal:       795612 kB 
MemFree:        312312 kB 
Buffers:          2568 kB 
Cached:         257868 kB 
SwapCached:          0 kB 
Active:          11284 kB 
Inactive:       251304 kB 
HighTotal:           0 kB 
HighFree:            0 kB 
LowTotal:       795612 kB 
LowFree:        312312 kB 
SwapTotal:     1355416 kB 
SwapFree:      1355416 kB 
Dirty:               0 kB 
Writeback:           0 kB 
Mapped:           5016 kB 
Slab:           210608 kB 
Committed_AS:     4580 kB 
PageTables:        136 kB 
VmallocTotal: 4294139904 kB 
VmallocUsed:      1308 kB 
VmallocChunk: 4294138596 kB 
¬root§53v15g05 root|# 

By the way, I noticed, that this patch slows down the find.

cheers

-- 
Mit freundlichen Grüßen / Best Regards

Christian Bornträger
IBM Deutschland Entwicklung GmbH
eServer SW  System Evaluation + Test
email: CBORNTRA@de.ibm.com
Tel +49  7031 16 1975


To:     Christian Borntraeger/Germany/IBM@IBMDE
cc:     Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, Patrick Mochel 
<mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>, 
dipankar@in.ltcfwd.linux.ibm.com 
Subject:        Re: [RFC 0/6] Backing Store for sysfs


On Mon, Oct 06, 2003 at 07:38:06PM +0200, Christian Borntraeger wrote:
> Greg KH wrote:
> 
> > On Mon, Oct 06, 2003 at 02:29:15PM +0530, Maneesh Soni wrote:
> >> 
> >> 2.6.0-test6          With patches.
> >> -----------------
> >> dentry_cache (active)                2520                    2544
> >> inode_cache (active)         1058                    1050
> >> LowFree                      875032 KB               874748 KB
> > 
> > So with these patches we actually eat up more LowFree if all sysfs
> > entries are searched, and make the dentry_cache bigger?  That's not 
good
> > :(
> [...]
> > information for that kobject.  So I don't see any savings in these
> > patches, do you?
> 
> I do. As stated earlier, with 20000 devices on a S390 guest I have 
around 
> 350MB slab memory after rebooting. 
> With this patch, the slab memory reduces to 60MB. 

That's good.  But what happens after you run a find over the sysfs tree?
Which is essencially what udev will be doing :)

thanks,

greg k-h



