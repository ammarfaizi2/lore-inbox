Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUHDRlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUHDRlo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 13:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267364AbUHDRlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 13:41:44 -0400
Received: from web81307.mail.yahoo.com ([206.190.37.82]:54351 "HELO
	web81307.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267363AbUHDRll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 13:41:41 -0400
Message-ID: <20040804174140.81473.qmail@web81307.mail.yahoo.com>
Date: Wed, 4 Aug 2004 10:41:40 -0700 (PDT)
From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: KVM & mouse wheel
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Marko Macek <Marko.Macek@gmx.net>, Jesper Juhl <juhl-lkml@dif.dk>,
       Eric Wong <eric@yhbt.net>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1833033864-1091641300=:80988"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1833033864-1091641300=:80988
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Vojtech Pavlik wrote:
> On Wed, Aug 04, 2004 at 07:38:55AM -0500, Dmitry Torokhov wrote:
> > On Wednesday 04 August 2004 02:18 am, Vojtech Pavlik wrote:
> > > On Wed, Aug 04, 2004 at 12:25:19AM -0500, Dmitry Torokhov wrote:
> > >
> > > > On Tuesday 03 August 2004 11:29 pm, Marko Macek wrote:
> > > > > Jesper Juhl wrote:
> > > > >
> > > > > > <>I also had problems with my KVM switch and mouse when I
> initially
> > > > > > moved to
> > > > > > 2.6, but adding this kernel boot parameter fixed it, meybe it
> will help
> > > > > > you as well : psmouse.proto=imps
> > > > >
> > > > > This doesn't help. Only the patch I sent helps me. The problem is
> that the
> > > > > even with psmouse.proto=imps or exps, the driver still probes for
> > > > > synaptics which I
> > > > > consider a bug.
> > > > >
> > > >
> > > > No it is not - Synaptics with a track-point on a passthrough port
> will have
> > > > track-point disabled if it is not reset after probing for imps/exps.
> > >
> > > Hmm, does the imps/exps probe succeed in this case?
> >
> > No, it does not, at least not mine. It either does bare PS/2 or native,
> but
> > there are other Synaptics touchpads that can also do imps.
> 
> Ok, so how about issuing a reset when the imps probe fails? That'd take
> care of all the cases, and I suppose a Synaptics pad that can do imps
> will not be confused by it.
> 

Synaptics requires full reset, reset-disable alone is not enough.
Plus, when synaptics is detected but left in emulation mode, the
driver does synaptics-specific reset which initializes stuff that
survives reset-disable (for example it enables gestures so tapping
is guaranteed to work).

Additionally I think it's a good idea to detect hardware regardless
of the protocol it is using so user can see what he has. 

Anyway, I think that explicitely calling reset-disable after each
failed probe is a good idea... or maybe not after each probe but just
once, before probing for generic protocols (imps/exps), like in the
attached patch.

--
Dmitry



--0-1833033864-1091641300=:80988
Content-Type: application/octet-stream; name="psmouse-probe.patch"
Content-Transfer-Encoding: base64
Content-Description: psmouse-probe.patch
Content-Disposition: attachment; filename="psmouse-probe.patch"

LS0tIGxpbnV4LTIuNi43L2RyaXZlcnMvaW5wdXQvbW91c2UvcHNtb3VzZS1i
YXNlLmMub3JpZwkyMDA0LTA4LTA0IDEyOjMwOjU1Ljk4NTgwNjQwMCAtMDUw
MAorKysgbGludXgtMi42LjcvZHJpdmVycy9pbnB1dC9tb3VzZS9wc21vdXNl
LWJhc2UuYwkyMDA0LTA4LTA0IDEyOjM0OjE1LjM5MjUzOTIwMCAtMDUwMApA
QCAtNDYxLDYgKzQ2MSwxMiBAQAogCQkJcmV0dXJuIHR5cGU7CiAJfQogCisv
KgorICogUmVzZXQgdG8gZGVmYXVsdHMgaW4gY2FzZSB0aGUgZGV2aWNlIGdv
dCBjb25mdXNlZCBieSBleHRlbmRlZAorICogcHJvdG9jb2wgcHJvYmVzLgor
ICovCisJcHNtb3VzZV9jb21tYW5kKHBzbW91c2UsIE5VTEwsIFBTTU9VU0Vf
Q01EX1JFU0VUX0RJUyk7CisKIAlpZiAobWF4X3Byb3RvID49IFBTTU9VU0Vf
SU1FWCAmJiBpbV9leHBsb3Jlcl9kZXRlY3QocHNtb3VzZSkpIHsKIAogCQlp
ZiAoc2V0X3Byb3BlcnRpZXMpIHsK

--0-1833033864-1091641300=:80988--
