Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUBXUrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbUBXUpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:45:32 -0500
Received: from smtpq2.home.nl ([213.51.128.197]:15579 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S262443AbUBXUoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:44:16 -0500
From: Gertjan van Wingerde <gwingerde@home.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: Cisco vpnclient prevents proper shutdown starting with 2.6.2
Date: Tue, 24 Feb 2004 21:41:40 +0100
User-Agent: KMail/1.6
Cc: ptoal@cisco.com, jhp@pobox.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402242141.40208.gwingerde@home.nl>
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick, et al.

Even though this seems to work, the real problem seems to lie in the cisco_ipsec module itself.
It looks like it is registering a netdevice notifier at ioctl time, which seems to deadlock in the lock
that has been introduced in 2.6.2. Moving the registration to module initialisation time (with the
proper checks in the event handler itself to only act when VPN is up) seems to resolve the
issue.

Patch to Cisco vpnclient 4.0.3.B is below.

	MvG,

		Gertjan.

diff -u --recursive vpnclient/interceptor.c vpnclient-new/interceptor.c
--- vpnclient/interceptor.c	2003-10-30 02:27:34.000000000 +0100
+++ vpnclient-new/interceptor.c	2004-02-24 21:26:36.000000000 +0100
@@ -364,11 +364,6 @@
         error = VPNIFUP_FAILURE;
         goto error_exit;
     }
-    error = register_netdevice_notifier(&interceptor_notifier);
-    if (error)
-    {
-        goto error_exit;
-    }
 
     vpn_is_up = TRUE;
     return error;
@@ -388,8 +383,6 @@
 {
     int i;
 
-    unregister_netdevice_notifier(&interceptor_notifier);
-
     cleanup_frag_queue();
     /*restore IP packet handler */
     if (original_ip_handler.pt != NULL)
@@ -436,6 +429,9 @@
 {
     struct net_device *dev = (struct net_device *) val;
 
+    if (!vpn_is_up)
+	return 1;
+
     switch (event)
     {
     case NETDEV_REGISTER:
@@ -853,6 +849,8 @@
         CNICallbackTable = *PCNICallbackTable;
         CniPluginDeviceCreated();
 
+        register_netdevice_notifier(&interceptor_notifier);
+
         if ((status = register_netdev(&interceptor_dev)) != 0)
         {
             printk(KERN_INFO "%s: error %d registering device \"%s\".\n",
@@ -876,6 +874,9 @@
     CniPluginUnload();
 
     unregister_netdev(&interceptor_dev);
+
+    unregister_netdevice_notifier(&interceptor_notifier);
+
     return;
 }
 


>Hi Patrick,
>
>Just a data point..
>
>I reversed this patch on a system running 2.6.3-mm2, and vpnclient now
>works.
>
>/harley
>
>> Newsgroups: fa.linux.kernel
>> Subject: RE: Cisco vpnclient prevents proper shutdown starting with 2.6.2
>> From: Patrick Toal <ptoal@cisco.com>
>> To: linux-kernel@vger.kernel.org
>> Date: Mon, 23 Feb 2004 01:36:17 GMT
>> 
>> Sid Boyce wrote:
>> > I tried using this client with up to 2.6.1-mm5 and ended up with Dead
>> > processes for cvpnd and vpnclient, nothing else was affected, went
>> > back to 2.4.x kernel.
>> > Regards
>> > Sid
>> 
>> Sid, et al. 
>> 
>> First, before anyone starts deluging me with questions, you should know
>> that even though my details say Cisco, I am an SE in the field, _not_ a
>> developer.  Second, please reply to me off-list, as I do not subscribe
>> to the LK list.  
>> 
>> That being said, I think I've tracked this down to a recent change in
>> the net/core/dev.c file.  I reversed the patch to
>> register_netdevice_notifier below, and the vpnclient now works fine. 
>> This is called by the handle_vpnup routine in interceptor.c of the
>> vpnclient kernel module.
>> 
>> I am _not_ a kernel developer, nor do I spend the majority of my time
>> programming, so I haven't been able to figure out _why_ these changes
>> cause the module to freeze.  I'd be interested if anyone could tell me
>> the answer to that question. :-)
>> 
>> Regards,
>> Patrick
>> 

<snip>
