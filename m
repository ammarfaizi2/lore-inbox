Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136734AbREAVKH>; Tue, 1 May 2001 17:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136730AbREAVIO>; Tue, 1 May 2001 17:08:14 -0400
Received: from pyongsan.compgen.com ([158.155.0.1]:61451 "EHLO
	panmunjom.compgen.com") by vger.kernel.org with ESMTP
	id <S136727AbREAVIE>; Tue, 1 May 2001 17:08:04 -0400
From: "Eric Z. Ayers" <Eric.Ayers@intec-telecom-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15087.9645.153829.265882@gargle.gargle.HOWL>
Date: Tue, 1 May 2001 17:07:57 -0400 (EDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Eric.Ayers@intec-telecom-systems.com, dledford@redhat.com (Doug Ledford),
        James.Bottomley@steeleye.com (James Bottomley),
        Chris.Roets@compaq.com (Roets Chris), linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: Linux Cluster using shared scsi
In-Reply-To: <E14uguj-0002KC-00@the-village.bc.nu>
In-Reply-To: <15086.60620.745722.345084@gargle.gargle.HOWL>
	<E14uguj-0002KC-00@the-village.bc.nu>
X-Mailer: VM 6.72 under 21.1 (patch 8) "Bryce Canyon" XEmacs Lucid
Reply-To: Eric.Ayers@intec-telecom-systems.com
X-Face: (3Y\Z;G!Ce[Q\WBgGFLgcaL%v[kJ'@9s`Qn1<)EEL5tSW7IDvX[{APQ5]eY}uF}%qbD[-@N
 !5]S!%o0*DbAB?~o%tca^?3@zU~"fQ@MTiClP>w%`Y8oG&6|:>2F=bhnf2>bPedqw-.T>U-BaI`F>1
 QY@?oGJ0.lV?b@0HgvaOt>=0,/@,=(kE"J++vO?K"3ve@,"sunF0HnU|h&|:}%|P6%BohO_*mAHJ#g
 EHc;_'bXG|kCLMSF`:/O_F0fuJ:j2^C\NJ(:$izN@mbXQo(IL,<P@2U+(Z`@>BO.7<]wT?:5.A<$C
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > > Does this package also tell the kernel to "re-establish" a
 > > reservation for all devices after a bus reset, or at least inform a
 > > user level program?  Finding out when there has been a bus reset has
 > > been a stumbling block for me.
 > 
 > You cannot rely on a bus reset. Imagine hot swap disks on an FC fabric. I 
 > suspect the controller itself needs to call back for problem events
 > 

I'm not an SCSI expert by any stretch of the imagination.  I think
that what you are saying is that you cannot rely that a bus reset is
as only thing that will remove a reservation.  For example, if a
device is 'hot replaced', the device will (clearly) no longer be
reserved.    But if you did such a hot swap you would have "bigger
fish to fry" in a HA application... I mean, none of your data would be
there! 

My understanding is that specifically, when a bus reset occurs,  all
SCSI reservations for devices on that bus are lost.  I was hoping that
if the kernel (by this I mean the scsi midlayer) was maintaining
reservations, that there would be some logic activated to "handle"
this problem, whether it be re-reserving the device, or the ability to
pass notification of a reset (or another problem event as you point
out) up to the application that's handling reservations. 

In my experience, the most common reason for a bus reset in parallel
SCSI is that a peer host on the bus is rebooting.  Since this happens
under normal operation and well in advance of any attempt to acess the
device, it would be nice if there were some sort of asyncronous
notification instead of a polling process with an interval of 2-3
minutes, where it's conceivable that the peer system could have booted
and attempted to take-over the disk out from under a running system.  

Bus resets in the Linux drivers also tend to happen frequently when a
disk is failing, which has tended to leave the system in a somewhat
functional but often an unusable state, (but that's a different story...)

James Bottomley <James.Bottomley@steeleye.com> writes:
 > Essentially, there are many conditions which cause a quiet loss of a SCSI-2 
 > reservation.  Even in parallel SCSI: Reservations can be silently lost because 
 >of LUN reset, device reset or even simple powering off the device.
...

James mentions that even handling a bus reset still leaves a window
where a peer could grab the reservation out from underneath an
un-suspecting host.  I agree that this could happen, and the old host
might perform writes to an 'unreserved' disk,  but once the second
system suceeded in obtaining the reservation, any read/write commands
from the "old" host would return SCSI errors (this is my layman's
understanding - the commands would return a UNIT_RESERVED error) , so
I believe you would have the desired behavior in this kind of cluster
- only one machine in the cluster can access the disk at the same
time.  The data on the disk should be in a state where the second
system in the cluster could start a recovery task and begin to provide
the service hosted on the disk. 

-Eric.
--
Eric Z. Ayers				              Lead Software Engineer
Phone:  +1 404-705-2864                    Computer Generation, Incorporated
Fax:    +1 404-705-2805                     an Intec Telecom Systems Company
Web:    http://www.intec-telecom-systems.com/
Email:  eric.ayers@intec-telecom-systems.com
Postal: Bldg G 4th Floor, 5775 Peachtree-Dunwoody Rd, Atlanta, GA 30342 USA
