Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261909AbVDVIYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbVDVIYj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 04:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVDVIYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 04:24:24 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:56210 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261878AbVDVIYA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 04:24:00 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH linux-2.6.12-rc2-mm3] smc91c92_cs: Reduce stack usage in smc91c92_event()
Date: Fri, 22 Apr 2005 11:22:51 +0300
User-Agent: KMail/1.5.4
Cc: dahinds@users.sourceforge.net, joern@wohnheim.fh-wedel.de,
       rddunlap@osdl.org
References: <df35dfeb05042115021c24638b@mail.gmail.com>
In-Reply-To: <df35dfeb05042115021c24638b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504221122.51579.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 April 2005 01:02, Yum Rayan wrote:
> This patch reduces the stack usage of the function smc91c92_event() in
> smc91c92_cs driver from 3540 to 132. Currently this is the highest
> stack user in linux-2.6.12-rc2-mm3. I used a patched version of gcc
> 3.4.3 on i386 with -fno-unit-at-a-time disabled.
> 
> The patch has only been compile tested. It would be nice to get
> feedback if someone that owns the hardware can actually test this
> patch.
> 
> Acked-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
> Acked-by: Randy Dunlap <rddunlap@osdl.org>
> Signed-off-by: Yum Rayan <yum.rayan@gmail.com>
> 
>  smc91c92_cs.c |  287 ++++++++++++++++++++++++++++++++++++++--------------------
>  1 files changed, 189 insertions(+), 98 deletions(-)
> 
> diff -Nupr -X dontdiff
> linux-2.6.12-rc2-mm3.a/drivers/net/pcmcia/smc91c92_cs.c
> linux-2.6.12-rc2-mm3.b/drivers/net/pcmcia/smc91c92_cs.c
> --- linux-2.6.12-rc2-mm3.a/drivers/net/pcmcia/smc91c92_cs.c	2005-04-14
> 22:15:43.000000000 -0700
> +++ linux-2.6.12-rc2-mm3.b/drivers/net/pcmcia/smc91c92_cs.c	2005-04-20
> 18:12:00.000000000 -0700
> @@ -127,6 +127,12 @@ struct smc_private {
>      int				rx_ovrn;
>  };
>  
> +struct smc_cfg_mem {
> +    tuple_t tuple;
> +    cisparse_t parse;
> +    u_char buf[255];
> +};
> +
>  /* Special definitions for Megahertz multifunction cards */
>  #define MEGAHERTZ_ISR		0x0380
>  
> @@ -498,14 +504,24 @@ static int mhz_mfc_config(dev_link_t *li
>  {
>      struct net_device *dev = link->priv;
>      struct smc_private *smc = netdev_priv(dev);
> -    tuple_t tuple;
> -    cisparse_t parse;
> -    u_char buf[255];
> -    cistpl_cftable_entry_t *cf = &parse.cftable_entry;
> +    struct smc_cfg_mem *cfg_mem;
> +    tuple_t *tuple;
> +    cisparse_t *parse;
> +    cistpl_cftable_entry_t *cf;
> +    u_char *buf;

I do it this way:

int f()
{
-	tuple_t tuple;
-	cisparse_t parse;
-	u_char buf[255];
+	struct {
+		tuple_t tuple;
+		cisparse_t parse;
+		u_char buf[255];
+	} local;
+	local = kmalloc(sizeof(*local),...); if(!local)...
	...
- š š	tuple.Attributes = tuple.TupleOffset = 0;
- š š	tuple.TupleData = (cisdata_t *)buf;
- š š	tuple.TupleDataMax = sizeof(buf);
+ š š	local->tuple.Attributes = local->tuple.TupleOffset = 0;
+ š š	local->tuple.TupleData = (cisdata_t *)local->buf;
+ š š	local->tuple.TupleDataMax = sizeof(local->buf);

I see the following advantages:

1) struct is unnamed and local to function
2) Variables do not change their type, the just sit in local-> now.
   I can just add 'local->' to each affected variable,
   without "it was an object, now it is a pointer" changes.
   No need to replace . with ->, remove &, etc.
3) I do not need to do this part of your patch which adds more locals:
+ š štuple_t *tuple;
+ š šcisparse_t *parse;
+ š šcistpl_cftable_entry_t *cf;
+ š šu_char *buf;
...
+ š štuple = &cfg_mem->tuple;
+ š šparse = &cfg_mem->parse;
+ š šbuf = cfg_mem->buf;
4) in resulting asm one base pointer instead of many will require
   less registers

Look into nfs4_proc_unlink_setup() for example.
I see that Trond do not use locally declared struct there,
but otherwise it is done as described above.
--
vda

