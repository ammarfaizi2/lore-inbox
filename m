Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292103AbSBAWA4>; Fri, 1 Feb 2002 17:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292106AbSBAWAr>; Fri, 1 Feb 2002 17:00:47 -0500
Received: from mg03.austin.ibm.com ([192.35.232.20]:10401 "EHLO
	mg03.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S292103AbSBAWAh>; Fri, 1 Feb 2002 17:00:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
Subject: Re: [evms-devel] [linux-lvm] [ANNOUNCE] LVM reimplementation ready for beta testing
Date: Fri, 1 Feb 2002 15:59:06 -0600
X-Mailer: KMail [version 1.2]
In-Reply-To: <OFBCE93B66.F7B9C14E-ON85256B52.006B8AB3@raleigh.ibm.com> <20020131125211.A8934@fib011235813.fsnet.co.uk>
In-Reply-To: <20020131125211.A8934@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Message-Id: <02020115304301.00650@boiler>
Content-Transfer-Encoding: 7BIT
To: Joe Thornber <thornber@fib011235813.fsnet.co.uk>, linux-lvm@sistina.com,
        evms-devel@lists.sourceforge.net
Cc: Jim McDonald <Jim@mcdee.net>, Andreas Dilger <adilger@turbolabs.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 January 2002 06:52, Joe Thornber wrote:
> On Thu, Jan 31, 2002 at 01:52:29PM -0600, Steve Pratt wrote:
> > No, not really.  We only put in the kernel the things that make sense to
> > be in the kernel, discovery logic, ioctl support, I/O path.  All
> > configuration is handled in user space.
>
> There's still a *lot* of code in there; > 26,000 lines in fact.
> Whereas device-mapper weighs in at ~2,600 lines.  This is just because
> you've decided to take a different route from us, you may be proven to
> be correct.

Just so everyone is clear on the amount of code we are talking about, here 
are my current counts of the different kernel drivers (based on code for 
2.4.17):

EVMS: 17685 (this includes drivers/evms and include/linux/evms)

device-mapper: 2895 (this includes device-mapper/kernel/common and 
device-mapper/kernel/ioctl - I've left out device-mapper/kernel/fs since only 
one interface can be active at a time)

Current MD and LVM1: 11105 (this includes drivers/md, include/linux/lvm.h, 
and include/linux/raid/)

Linux 2.4.17: 2519386 (a clean kernel, without EVMS or the latest LVM1 
updates, and not counting asm code)

See http://www.dwheeler.com/sloccount/ for the tool that I used to get these 
counts. 

So I will agree - device-mapper does provide a nice, general-purpose I/O 
remapping service in a small amount of code. Kernel bloat is obviously a big 
concern as more functionality is added to Linux, and achieving a desired set 
of functionality with less code is generally a good thing.

However, I don't think that the size of EVMS should just be written off as 
kernel bloat. (I don't think any of the LVM guys have specifically said this, 
but I have heard this comment from others, and I don't think they are looking 
at the whole picture). We are talking about seven-tenths of a one percent 
increase in the total size of the kernel. And if you consider that EVMS has 
implemented support for LVM1 and MD, then EVMS is really only adding 6580 
lines of code to the kernel. On top of that, EVMS has support for several 
disk partitioning formats. (This support does not yet fully duplicate the 
advanced partition support in the kernel, so I can't yet give any definite 
numeric comparisons.) There is also support for the AIX LVM and the OS/2 LVM, 
as well as general bad-block-relocation and snapshotting support. For all of 
this extra functionality, I don't believe the extra code is unwarranted.

> I would like the two projects to help each other, but not to the point
> where one group of people has to say 'you are completely right, we
> will stop developing our project'.  It's unlikely that either of us is
> 100% correct; but I do think device-mapper splits off a nice chunk of
> services that is useful to *all* people who want to do volume
> management.  As such I see that as one area where we may eventually
> work together.
>
> Similarly I expect to be providing an *optional* kernel module for LVM
> users who wish to do in kernel discovery of a root LV, so if the EVMS
> team has managed to get a nice generic way of iterating block devices
> etc.  into the kernel, we would be able to take advantage of that.
> Are you trying to break out functionality so it benefits other Linux
> projects ? or is EVMS just one monolithic application embedded in the
> kernel ?

I have been thinking about this today and looking over some of the 
device-mapper interfaces. I will agree that, in concept, EVMS could be 
modified to use device-mapper for I/O remapping. However, as things stand 
today, I don't think the transition would be easy.

As I'm trying to envision it, the EVMS runtime would become a "volume 
recognition" framework (see tanget below). Every current EVMS plugin would 
then probe all available devices and communicate the necessary volume 
remapping info to device-mapper through the ioctl interface. (An in-kernel 
API set might be nice to avoid the overhead of the ioctl path). A new device 
would then be created for every node that every plugin recognizes. This 
brings up my first objection. With this approach, there would be an exposed 
device for every node in a volume stack, whereas the current EVMS design only 
exposes nodes for the final volumes. Ignoring the dwindling minor-number 
issue which should go away in 2.5, you still take up space in the 
buffer-cache for every one of these devices, which introduces the possibility 
of cache-incoherencies.

Maybe this example will help: Say we have four disks. These four disks have 
one partition each, and are striped together with RAID-0 (using MD). This MD 
device is then made into an LVM PV and put in a volume group, and an LV is 
created from part of the space in that group. Then down the line, you decide 
to do some backups, and create another LV to use as a snapshot of the first 
LV. (For those who might be wondering, this is a very realistic scenario.)


                  Snap_of_LV1
                      |
          LV1        LV2
          _|__________|_
         | Volume Group |
          --------------
                | 
               md0
   _____________|_______________
  |         |         |         |
 sda1      sdb1      sdc1      sdd1
  |         |         |         |
 sda       sdb       sdc       sdd

In this scenario, we would wind up with exposed devices for every item in 
this graph (except the volume group). But in reality, we don't want someone 
coming along and mucking with md0 or with LV2 or with any of the disk 
partitions, because they are all in use by the two volumes at the top.

<tangent>

As we know, EVMS does volume discovery in the kernel. LVM1 does discovery in 
user-space, but Joe has hinted at an in-kernel LVM1 discovery module to work 
with device-mapper. Back when we started on EVMS, people were basically 
shouting "we need in-kernel discovery!", so that's the route we took. This is 
why it looks like EVMS has so much code. I'd say 50-75% of each plugin is 
devoted to discovery. Of course, today there seem to be people shouting, 
"let's move all discovery into user-space!". Well, I suppose that approach is 
feasible, but I personally don't agree with it. My belief is that it's the 
kernel's job to tell user-space what the hardware looks like, not the other 
way around. If we move partition/volume/etc discovery into user-space, at 
what point do we move device recognition into user-space? Looking down that 
path just seems more and more like a micro-kernel approach, and I'm sure we 
don't want to rehash that discussion.

</tangent>

Next, from what I've seen, device-mapper provides static remappings from one 
device to another. It seems to be a good approach for setting up things like 
disk partitions and LVM linear LVs. There is also striping support in 
device-mapper, but I'm assuming it uses one notion of striping. For instance, 
RAID-0 striping in MD is handled differently than striped LVs in LVM, and I 
think AIX striping is also different. I'm not sure if one stiping module 
could be generic enough to handle all of these cases. But, maybe it can. I'll 
have to think more about that one.

How about mirroring? Does the linear module in device-mapper allow for 1-to-n 
mappings?  This would be similar to the way AIX does mirroring, where each LP 
of an LV can map to up to three PPs on different PVs.

How would device-mapper handle a remapping that is dynamic at runtime? For 
instance, how would device-mapper handle bad-block-relocation? Actually, it 
seems you have dealt with this from one point of view in the snapshotting 
code in device-mapper. In order for persistent snapshots (or bad-block) to 
work, device-mapper needs a module which knows the metadata format, because 
that metadata has to be written at runtime. So another device-mapper "module" 
would need to be written to handle bad-block. This implicitly limits the 
capabilities of device-mapper, or else ties it directly to the recognition 
code. For EVMS and device-mapper to work together, we would have to agree on 
metadata formats for these types of modules. Other similar example that come 
to mind are RAID-5 and block-level encryption.

Now, don't get me totally wrong. I'm not saying using device-mapper in EVMS 
is impossible. I'm just pointing out some of the issues I currently see with 
making such a transition. Perhaps some of these issues can be addressed, from 
either side.

Ultimately, I agree with Joe and Alasdair - I think there is room for both 
projects. There are plenty of other examples of so-called competing projects 
that co-exist just fine - KDE/Gnome, ReiserFS/JFS/XFS/ext3 - hell, there's 
even two virtual memory managers to choose from! So if it just turns out that 
Linux has a choice of two volume managers, then I don't have any problem with 
it. I will say that it is somewhat unfortunate that we couldn't have worked 
together more, but it seems to me that timing is what kept it from happening. 
EVMS was under development when LVM was getting ready for their 1.0 release, 
and now EVMS is trying to get a final release out as the new device-mapper is 
coming along. Unfortunately we each have our own deadlines to think about. 
Maybe down the line there will be more time to get together and figure out 
ways to get these different technologies to work together.

-Kevin
 
