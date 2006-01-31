Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750804AbWAaNN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbWAaNN5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWAaNN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:13:57 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:49369 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1750804AbWAaNN4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:13:56 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: "Gabriel C." <crazy@pimpmylinux.org>
Subject: Re: 2.6.16-rc1-mm4: ACX=y, ACX_USB=n compile error
Date: Tue, 31 Jan 2006 14:16:05 +0200
User-Agent: KMail/1.8.2
Cc: da.crew@gmx.net, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, linville@tuxdriver.com,
       netdev@vger.kernel.org
References: <20060130133833.7b7a3f8e@zwerg> <200601310810.33107.vda@ilport.com.ua> <20060131100330.2931cbe9@zwerg>
In-Reply-To: <20060131100330.2931cbe9@zwerg>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_FU13DPqDjbVX1Mv"
Message-Id: <200601311416.05397.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_FU13DPqDjbVX1Mv
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 31 January 2006 11:03, Gabriel C. wrote:
> > > > I got this compile error with 2.6.16-rc1-mm4 , config attached. 
> > > > 
> > > > 
> > > >   LD      .tmp_vmlinux1
> > > > drivers/built-in.o: In function
> > > > `acx_l_transmit_authen1':common.c:(.text+0x6cd62): undefined
> > > > reference to `acxusb_l_alloc_tx' :common.c:(.text+0x6cd74):
> > > > undefined reference to
> > > > `acxusb_l_get_txbuf' :common.c:(.text+0x6cdeb): undefined
> > > > reference to `acxusb_l_tx_data' drivers/built-in.o: In function
> > > > `acx_s_configure_debug': undefined reference to
> > > > `acxusb_s_issue_cmd_timeo_debug' drivers/built-in.o: In function
> > > > [many more]
> > > >...
> > > 
> > > Thanks for your report.
> > > 
> > > @Denis:
> > > The problem seems to be CONFIG_ACX=y, CONFIG_ACX_USB=n.
> > 
> > Thanks, will test/fix ASAP.

CONFIG_ACX=y
# CONFIG_ACX_PCI is not set
# CONFIG_ACX_USB is not set

This won't fly. You must select at least one.

Attached patch will check for this and #error out.
Andrew, do not apply to -mm, I'll send you bigger update today.
--
vda

--Boundary-00=_FU13DPqDjbVX1Mv
Content-Type: text/x-diff;
  charset="koi8-r";
  name="acx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="acx.patch"

diff -urpN linux-2.6.16-rc1-mm4.org/drivers/net/wireless/tiacx.org/acx_struct.h linux-2.6.16-rc1-mm4.org/drivers/net/wireless/tiacx/acx_struct.h
--- linux-2.6.16-rc1-mm4.org/drivers/net/wireless/tiacx.org/acx_struct.h	Tue Jan 31 12:13:53 2006
+++ linux-2.6.16-rc1-mm4.org/drivers/net/wireless/tiacx/acx_struct.h	Tue Jan 31 13:51:18 2006
@@ -121,6 +121,10 @@ enum { acx_debug = 0 };
 #define DEVTYPE_PCI		0
 #define DEVTYPE_USB		1
 
+#if !defined(CONFIG_ACX_PCI) && !defined(CONFIG_ACX_USB)
+#error Driver must include PCI and/or USB support. You selected neither.
+#endif
+
 #if defined(CONFIG_ACX_PCI)
  #if !defined(CONFIG_ACX_USB)
   #define IS_PCI(priv)	1

--Boundary-00=_FU13DPqDjbVX1Mv--
