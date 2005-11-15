Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVKOArG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVKOArG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbVKOArG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:47:06 -0500
Received: from web50106.mail.yahoo.com ([206.190.38.34]:27574 "HELO
	web50106.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932253AbVKOArF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:47:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=JFuIHmmrU4gx/sm5egDLkXCnVCkS+jdHKvXffULO0tLI+9bkVwlRMqZgU7eY2TuyAteaHQ8QIvl5S9K0U/SnIqJxY15g4B5xT/AKyY3N94UrsqoBD9FzCWex//cACl/qxbQdLcc55TWBxKcTfIInYVLYbf0Rc8Hic4DG4wUkC9c=  ;
Message-ID: <20051115004704.91557.qmail@web50106.mail.yahoo.com>
Date: Mon, 14 Nov 2005 16:47:03 -0800 (PST)
From: Doug Thompson <norsk5@yahoo.com>
Subject: Re: [RFC] EDAC and the sysfs
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051114223105.GA5868@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is EDAC and what does it stand for?

EDAC= Error Detection And Correction.

It currently is in the -mm2 tree, but with the older
files and controls location. 

The primary purpose of 'edac' (formerly
blusmoke.sourceforge.net) is to provide a DETECTOR
module of various errors detected by the hardware. The
main detector has been the detecting of ECC memory
errors of memory controllers. PCI Parity scanning was
recently added.

Uncorrected ECC Errors (UE) are detected if the
machinecheck is not configured in the kernel, since
the machinecheck will occur synchronous with the
error, edac polss.  edac can log UEs and panic if the
control is set for panic_on_ue. edac logs Corrected
ECC Errors (CE) to the sys concole and it is output.

edac is a two component system. edac_mc is the core
and then one of several memory controller (mc) modules
is used as the mc driver. edac_k8 is the
opteron/athlon64 modules. The mc driver can then
extract the mc specific information and abstract it
and send the information to the edac_mc core. 

The current information file in /proc/mc/0 (for CPU
0's mc) is as follows:

Check PCI Parity:       1
Panic PCI Parity:       1
Panic UE:               1
Log UE:                 1
Log CE:                 1
Poll msec:              1000

MC Core:                bluesmoke_mc  Ver: 2.0.3 Nov
11 2005
MC Module:              bluesmoke_k8  Ver: 2.0.2 Nov
11 2005
Memory Controller:      Athlon64/Opteron
PCI Bus ID:             0000:00:18.2 (0000:00:18.2)
EDAC capability:        None SECDED S4ECD4ED
Current EDAC capability:        None SECDED S4ECD4ED
Supported Mem Types:    Unbuffered-DDR Registered-DDR

0:H0_DIMM0|H0_DIMM1:Memory Size:        1024 MiB
0:H0_DIMM0|H0_DIMM1:Mem Type:           Registered-DDR
0:H0_DIMM0|H0_DIMM1:Dev Type:           x4
0:H0_DIMM0|H0_DIMM1:EDAC Mode:          S4ECD4ED
0:H0_DIMM0|H0_DIMM1:UE:                 0
0:H0_DIMM0|H0_DIMM1:CE:                 0
0.0:H0_DIMM0:CE:                0
0.1:H0_DIMM1:CE:                0

1:H0_DIMM0|H0_DIMM1:Memory Size:        1024 MiB
1:H0_DIMM0|H0_DIMM1:Mem Type:           Registered-DDR
1:H0_DIMM0|H0_DIMM1:Dev Type:           x4
1:H0_DIMM0|H0_DIMM1:EDAC Mode:          S4ECD4ED
1:H0_DIMM0|H0_DIMM1:UE:                 0
1:H0_DIMM0|H0_DIMM1:CE:                 0
1.0:H0_DIMM0:CE:                0
1.1:H0_DIMM1:CE:                0

Total Memory Size:      2048 MiB
Seconds since reset:    270160
UE No Info:             0
CE No Info:             0
Total UE:               0
Total CE:               0
Total PCI Parity:       0


<end paste>

Yes, this output is way too monolithic and needs to be
refactored. I aim to move this output to the new sysfs
destination, but in a different format via different
files.

The output show UE and CE counts arranged by CSROW and
by Channel 0 or Channel 1. These are also tagged with
the motherboard silk screen labels (Arima's HDAMA mobo
is the example:  H0_DIM0, etc). This allows the
adminstrator to harvest this data and map to the node
AND DIMM slot for replacement.

The above also has PCI device parity scanning
information, which will be broken out as mentioned in
my original posting. We have found flaws in PCI riser
cards with this scanning process, which caused
unreported data corruption in high speed
interconnects. BUT not all devices  conform to the PCI
spec on parity generation. (as usual)



--- Greg KH <greg@kroah.com> wrote:

> On Mon, Nov 14, 2005 at 02:14:19PM -0800, Doug
> Thompson wrote:
> > 
> > I am trying to design the sysfs interface tree for
> the
> > new set of EDAC modules that are waiting for this
> > interface, before being put into the kernel.  
> > 
> > Currently the original EDAC (bluesmoke) has its
> own
> > /proc directory (/proc/mc) with files and a
> directory
> > (0,1,2,...)for each memory controller on the
> system.
> > This will be removed and the new information
> interface
> > will be placed in the sysfs.
> > 
> > One proposal is to place the information in
> > /sys/devices/system in the following directories:
> 
> Why not use /sys/firmware/ instead?

I guess my initial explaination was not clear enough. 
This doesn't fit, and I assume you see this now from
the above explaination.

> 
> Or do you want to use the struct device stuff
> 
> > For EDAC general memory ECC controls and
> information
> > files:
> > 
> >    /sys/devices/systems/edac/mc/
> 
> What kind of controls and files?

Abstracted mc files, taken from the above older
monolithic output:

mc_core_version
mc_driver_version
memory_controller
device_bus_id  (symlink)
edac_capability
current_edac_capability
supported_mem_types
seconds_since_counter_reset
total_memory_size 
total_ue_noinfo_count
total_ce_noinfo_count
total_ue_count
total_ce_count

[the no_info counts are respective errors, but the
edac mc drivers could not determine more information
on it, hence a no_info count]

Controls:

panic_on_ue
log_ue
log_ce
poll_interval_msec



These controls are also set via module load options.


> 
> > 
> > For PCI Parity Error detection controls and
> > information files:
> > 
> >    /sys/devices/system/edac/pci
> 
> That kind of controls and  files?

Controls:

check_pci_parity
panic_on_pci_parity


info files:

total_pci_parity_count


> 
> 
> > In addition /sys/devices/system/edac/mc/ would 
> have
> > directories:
> > 
> > mc0/
> > mc1/
> > ...
> > 
> > for each memory controller's specific controls and
> > information.
> 
> Again, what kind of controls and information?

For each Chip-Select Row (csrow) there would be
information. I am still trying to determine if each
csrow would be in its own directory or all cwrows just
flat in the mc0, mc1, ... directories. 

Assuming each csrow is in its own directory (which is
the way I am leaning) below:

csrow0/
csrow1/
csrow2/
csrow3/
...

info files in the above directories:

memory_size
memory_type
device_type
edac_mode
ue_count
ce_count
ce_count_channel_0
ce_count_channel_1
dimm_label
dimm_label_channel_0
dimm_label_channel_1


controls:

none at this time

--------------
>From this data, a reaper/harvester can determine the
CE rate, which is the main real value in EDAC at this
time, and notify the admin of preventative
maintainance work.

> 
> > Currently the similiar error detection device
> > /sys/devices/system/machinecheck resides here are
> > well.
> > 
> > 
> > The alternative layout would be to use the
> /sys/class
> > directory when nested-classes become available:
> 
> They are in 2.6.15-rc1, but you _really_ don't want
> to use them, they
> are a huge pain, and I will be getting rid of them,
> along with all
> struct class_device stuff in the near future.  See
> the archives for
> details, or it's summarized here:

interesting. That info is what I was looking for. 
BTW, thanks for starting the 'HOWTO do kernel
development'

> 
>
http://www.kroah.com/log/linux/driver_model_changes.html
> 
> 
> > 
> > /sys/class/edac/mc/...
> > 
> > and
> > 
> > /sys/class/edac/pci/...
> > 
> > But edac doesn't quite seem to fit here.
> 
> I agree.
> 
> > I have failed to date to really find a policy or
> set
> > of rules of use for the sysfs as to what goes
> where
> > for such items as EDAC. After searching the web,
> > articles and thinking about this for some time
> now, I
> > am requesting comments on the sysfs model for
> where
> > EDAC would fit best.
> 
> What exactly does EDAC do (and what does it stand
> for anyway?)

see beginning of this post

> 
> thanks,
> 
> greg k-h
> 


thank you greg, for the specific questions to clarify
my request.


doug t



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

