Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVFNGIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVFNGIb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 02:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbVFNGIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 02:08:31 -0400
Received: from smtp830.mail.sc5.yahoo.com ([66.163.171.17]:63897 "HELO
	smtp830.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261233AbVFNGIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 02:08:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Greg KH <gregkh@suse.de>
Subject: Re: Input sysbsystema and hotplug
Date: Tue, 14 Jun 2005 01:08:16 -0500
User-Agent: KMail/1.8.1
Cc: linux-hotplug-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>, Vojtech Pavlik <vojtech@suse.cz>,
       LKML <linux-kernel@vger.kernel.org>, Hannes Reinecke <hare@suse.de>,
       Andrew Morton <akpm@osdl.org>
References: <200506131607.51736.dtor_core@ameritech.net> <200506131705.30159.dtor_core@ameritech.net> <20050613221500.GA15381@suse.de>
In-Reply-To: <20050613221500.GA15381@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506140108.16737.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 June 2005 17:15, Greg KH wrote:
> On Mon, Jun 13, 2005 at 05:05:29PM -0500, Dmitry Torokhov wrote:
> > On Monday 13 June 2005 16:58, Dmitry Torokhov wrote:
> > > On Monday 13 June 2005 16:26, Kay Sievers wrote:
> > > > On Mon, Jun 13, 2005 at 04:07:51PM -0500, Dmitry Torokhov wrote:
> > > > > I am trying to convert input systsem to play nicely with sysfs and I am
> > > > > having trouble with hotplug agent. The old hotplug mechanism was using
> > > > > "input" as agent/subsystem name, unfortunately I can't simply use "input"
> > > > > class because when Greg added class_simple support to input handlers
> > > > > (evdev, mousedev, joydev, etc) he used that name. So currently stock
> > > > > kernel gets 2 types of hotplug events (from input core and from input
> > > > > handlers) with completely different arguments processed by the same
> > > > > input agent.
> > > > > 
> > > > > So I guess my question is: is there anyone who uses hotplug events
> > > > > for input interface devices (as in mouseX, eventX) as opposed to
> > > > > parent input devices (inputX).
> > > > 
> > > > Hmm, udev uses it. But, who needs device nodes. :)
> > > > 
> > > 
> > > Oh, OK. Damn, Andrew will hate us for breaking mouse support yet again :(
> > > because there are people (like me) relying on hotplug to load input handlers.
> > > First time I booted by new input hotplug kernel I lost my mouse.
> > > 
> > > I wonder should we hack something allowing overriding subsystem name
> > > so we could keep the same hotplug agent? Or should we bite teh bullet and
> > > change it?
> > >
> > 
> > Any chance we could quickly agree on a new name for hander devices (other
> > than "input") and roll out updated udev before the changes get into the
> > kernel? For some reason it feels like udev is mmuch quicker moving than
> > hotplug...
> 
> I can roll another hotplug release any time you want, there's nothing
> holding that back.
> 
> But please, don't break old users of hotplug or udev.  Especially
> hotplug (for udev one can argue that it's still so new that upgrading is
> realistic, but try to prevent that too...) as that package is so tightly
> tied to the distro, the next time it would be upgraded is for the next
> distro release.
> 
> So, any way to not break anything?
>

We could allow classes override what is being transmitted as SUBSYSTEM=
in hotplug call. If you accept something like the patch below we can keep
status quo.
  
-- 
Dmitry

Subject: allow classes specify subsystem name for hotplug

Driver core: allow classes specify subsystem name to use in
             hotplug call instead of always using their sysfs
             name.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/base/class.c   |    4 +++-
 include/linux/device.h |    1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: work/drivers/base/class.c
===================================================================
--- work.orig/drivers/base/class.c
+++ work/drivers/base/class.c
@@ -268,8 +268,10 @@ static int class_hotplug_filter(struct k
 static char *class_hotplug_name(struct kset *kset, struct kobject *kobj)
 {
 	struct class_device *class_dev = to_class_dev(kobj);
+	struct class *class = class_dev->class;
 
-	return class_dev->class->name;
+	return class->hotplug_name ?
+			class->hotplug_name(class_dev) : class->name;
 }
 
 static int class_hotplug(struct kset *kset, struct kobject *kobj, char **envp,
Index: work/include/linux/device.h
===================================================================
--- work.orig/include/linux/device.h
+++ work/include/linux/device.h
@@ -153,6 +153,7 @@ struct class {
 	struct class_attribute		* class_attrs;
 	struct class_device_attribute	* class_dev_attrs;
 
+	char * (*hotplug_name)(struct class_device *dev);
 	int	(*hotplug)(struct class_device *dev, char **envp, 
 			   int num_envp, char *buffer, int buffer_size);
 
