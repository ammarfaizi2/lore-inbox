Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbUKZTfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbUKZTfU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbUKZTeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:34:18 -0500
Received: from zeus.kernel.org ([204.152.189.113]:33218 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261212AbUKZTZF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:25:05 -0500
Subject: Re: modprobe + request_module() deadlock
From: Rusty Russell <rusty@rustcorp.com.au>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Gerd Knorr <kraxel@suse.de>, Johannes Stezenbach <js@convergence.de>,
       Johannes Stezenbach <js@linuxtv.org>, Takashi Iwai <tiwai@suse.de>,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041125160339.GA3504@bytesex>
References: <20041122102502.GF29305@bytesex>
	 <20041122141607.GA21184@linuxtv.org> <20041122144432.GB575@bytesex>
	 <20041122153637.GA10673@convergence.de> <20041122165201.GA2060@bytesex>
	 <1101272551.6186.25.camel@localhost.localdomain>
	 <20041125160339.GA3504@bytesex>
Content-Type: text/plain
Date: Fri, 26 Nov 2004 11:34:12 +1100
Message-Id: <1101429252.6996.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-25 at 17:03 +0100, Gerd Knorr wrote:
> On Wed, Nov 24, 2004 at 04:02:31PM +1100, Rusty Russell wrote:
> > On Mon, 2004-11-22 at 17:52 +0100, Gerd Knorr wrote:
> > > > > I can fix that in the driver, by delaying the request_module() somehow
> > > > > until the saa7134 module initialization is finished.  I don't think that
> > > > > this is a good idea through as it looks like I'm not the only one with
> > > > > that problem ...
> > > > 
> > > > Delaying request_module() sounds ugly. Anyway, if you can
> > > > get it to work reliably...
> > > 
> > > I think I can, havn't tried yet through.
> 
> Untested proof-of-concept code (don't have a saa7134 card in my machine
> at the moment), but that way it could work I think.  Tried to keep it
> generic.  Basically it keeps a list of pending module loads and the
> dependencies.  Then it hooks into the module state notifier chain and
> calls request_module() once the depending module went to LIVE state.
> 
> Comments?

A little generic for my tastes.  I was thinking more like the below
(equally untested).  Note that strictly we should call the module
notifier for NULL at the end of the boot sequence, too.
===
static int want_empress, want_dvb;

/* These need our symbols: we must be fully loaded for them to load */
static int pending_call(struct notifier_block *self, unsigned long state,
			void *module)
{
	if (module != THIS_MODULE || state != MODULE_STATE_LIVE)
		return NOTIFY_DONE;

	if (want_empress)
		request_module("saa7134-empress");
	if (want_dvb)
		request_module("saa7134-dvb);
	return NOTIFY_DONE;
}

static struct notifier_block pending_notifier = {
	.notifier_call = pending_call,
};

int init(void)
{
,,,
	register_module_notifier(&pending_notifier);
}

void cleanup(void)
{
...
	unregister_module_notifier(&pending_notifier);
}


-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

