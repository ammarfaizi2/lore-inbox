Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266387AbUFUSev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266387AbUFUSev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 14:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUFUSev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 14:34:51 -0400
Received: from gprs187-64.eurotel.cz ([160.218.187.64]:897 "EHLO
	midnight.ucw.cz") by vger.kernel.org with ESMTP id S266387AbUFUSeY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 14:34:24 -0400
Date: Mon, 21 Jun 2004 20:34:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Michael Langley <nwo@hacked.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with psmouse detecting generic ImExPS/2
Message-ID: <20040621183459.GA1969@ucw.cz>
References: <20040621021651.4667bf43.nwo@hacked.org> <20040621082831.GC1200@ucw.cz> <20040621124506.18b1f67a.nwo@hacked.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20040621124506.18b1f67a.nwo@hacked.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 21, 2004 at 12:45:06PM -0500, Michael Langley wrote:
> On Mon, 21 Jun 2004 10:28:31 +0200
> Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > On Mon, Jun 21, 2004 at 02:16:51AM -0500, Michael Langley wrote:
> > > I noticed this after upgrading 2.6.6->2.6.7
> > > 
> > > Even after building psmouse as a module, and specifying the protocol,
> > > all I get is an ImPS/2 Generic Wheel Mouse.
> > > 
> > > [root@purgatory root]# modprobe psmouse proto=exps
> > > Jun 21 01:51:57 purgatory kernel: input: ImPS/2 Generic Wheel Mouse on
> > > isa0060/serio1
> > > 
> > > My ImExPS/2 was detected correctly in <=2.6.6 and after examining the
> > > current psmouse code, and the changes in patch-2.6.7, I can't figure out
> > > what's breaking it.  A little help?
> >  
> > Maybe your mouse needs the ImPS/2 init before the ExPS/2 one. You can
> > try to copy and-paste the ImPS/2 init once more in the code, without a
> > return, of course.
> > 
> > -- 
> > Vojtech Pavlik
> > SuSE Labs, SuSE CR
> 
> 
> Right.  That did the trick.

> [root@purgatory root]# modprobe psmouse proto=exps
> Jun 21 12:41:36 purgatory kernel: input: ImExPS/2 Generic Wheel Mouse on isa0060/serio1
> 
> Much thanks for the help.  I couldn't live without the extra buttons in X.

Can you check if this patch fixes it for you as well?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=imex-fix

ChangeSet@1.1767, 2004-06-21 20:31:56+02:00, vojtech@suse.cz
  input: when probing for ImExPS/2 mice, the ImPS/2 sequence needs
         to be sent first, but the result should be ignored.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 psmouse-base.c |    2 ++
 1 files changed, 2 insertions(+)


diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-06-21 20:32:54 +02:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-21 20:32:54 +02:00
@@ -418,6 +418,8 @@
 {
 	unsigned char param[2];
 
+	intellimouse_detect(psmouse);
+
 	param[0] = 200;
 	psmouse_command(psmouse, param, PSMOUSE_CMD_SETRATE);
 	param[0] = 200;
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>

--7AUc2qLy4jB3hD7Z--
