Return-Path: <linux-kernel-owner+w=401wt.eu-S1161153AbXALWyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161153AbXALWyp (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 17:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161155AbXALWyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 17:54:45 -0500
Received: from hera.kernel.org ([140.211.167.34]:34836 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161153AbXALWyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 17:54:44 -0500
From: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Frederik Deweerdt <deweerdt@free.fr>
Subject: Re: Early ACPI lockup (was Re: 2.6.20-rc4-mm1)
Date: Fri, 12 Jan 2007 17:53:08 -0500
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       rui.zhang@intel.com
References: <20070111222627.66bb75ab.akpm@osdl.org> <20070112102040.GD5941@slug>
In-Reply-To: <20070112102040.GD5941@slug>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701121753.08710.lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 January 2007 05:20, Frederik Deweerdt wrote:
> On Thu, Jan 11, 2007 at 10:26:27PM -0800, Andrew Morton wrote:
> > 
> >   ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc4-mm1/
> > 
> Hi,
> 
> The git-acpi.patch replaces earlier "if(!handler) return -EINVAL" by
> "BUG_ON(!handler)". This locks my machine early at boot with a message
> along the lines of (It's hand copied):
> Int 6: cr2: 00000000 eip: c0570e05 flags: 00010046 cs: 60
> stack: c054ffac c011db2b c04936d0 c054ff68 c054ffc0 c054fff4 c057da2c
> 
> Reverting the change as follows, allows booting:
> Any ideas to debug this further?


> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index db0c5f6..fba018c 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -414,7 +414,9 @@ int __init acpi_table_parse(enum acpi_ta
>  	unsigned int index;
>  	unsigned int count = 0;
>  
> -	BUG_ON(!handler);
> +	if (!handler)
> +		return -EINVAL;
> +	/*BUG_ON(!handler);*/
>  
>  	for (i = 0; i < sdt_count; i++) {
>  		if (sdt_entry[i].id != id)

What do you see if on failure you also print out the params, like below?

thanks,
-Len

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 3fce3db..e2d08a5 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -415,7 +415,12 @@ int __init acpi_table_parse(enum acpi_table_id id, acpi_table_handler handler)
 	unsigned int index = 0;
 	unsigned int count = 0;
 
-	BUG_ON(!handler);
+	if (!handler) {
+		printk(KERN_WARNING PREFIX
+			"acpi_table_parse(%d, %p) %s NULL handler!\n",
+			id, handler, acpi_table_signatures[id]);
+		return -EINVAL;
+	}
 
 	for (i = 0; i < sdt_count; i++) {
 		if (sdt_entry[i].id != id)


