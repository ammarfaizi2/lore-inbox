Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279017AbRJZTl4>; Fri, 26 Oct 2001 15:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279024AbRJZTlg>; Fri, 26 Oct 2001 15:41:36 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:34552 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S279017AbRJZTl2>; Fri, 26 Oct 2001 15:41:28 -0400
Date: Fri, 26 Oct 2001 12:42:12 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch to read/parse the MPC oem tables
Message-ID: <3372752995.1004100132@[10.10.1.2]>
In-Reply-To: <3BD98768.6A99BD80@osdl.org>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This patch will parse the OEM extensions to the mps tables
>> (if present). This gives me a mapping to tell which device
>> lies in which NUMA node (the current code just guesses).
> 
> So these extensions are OEM-specific, not part of the MP spec,
> right?

As I understand this, the concept of OEM extensions is inside
the MPS spec (there's a pointer for it inside the main table), 
though what's actually contained therein is OEM specific.

>> +static int mpc_record;
>> +static struct mpc_config_translation *translation_table[MAX_MPC_ENTRY];
> 
> Could this array be __initdata or reduced in size some,
> for people who don't need it?  (more about this below)
> E.g., I bet most people don't need this static 4 KB array.

I originally had this under #ifdef, but that causes compilation 
problems. __initdata is probably better - thanks. Tested it, 
seems to work fine.
 
> Also, could the array of structs <mp_irqs and mp_ioapics> (in
> mpparse.c) be made __initdata, so that they could be discarded
> after init?

Probably, but they're used in lots of places, so it would take some
research to figure out all the possible combinations ;-) I'll leave that
possiblity for a seperate patch (the structures were there already
like this).

> Add "else" here to keep from stepping out of the array bounds.

Good point. Fixed.
 
> BTW, "%p" prints pointers also, without casting them.

OK, I'll try that.
 
>> +               mpc_record = 0;
> 
> What's this =0 for?
> ...
> And what's this increment for?

We go round the counter twice - the only way to match up the 
records in the trans table to the records in the main table is by
their position. The first time we go round the counter (for the 
trans table), we record everything in it's appropriate position in
the trans array, the next time, the counter is an index to fish 
things back out of the trans array by.

Or, at least, that was the intent ;-) Seems to work.

>> +#define MAX_MPC_ENTRY 1024
> 
> How about #defining MAX_MPC_ENTRY above here (depending on MULTIQUAD),
> so that it can be smaller for non-MULTIQUAD targets?

That would be slightly messy - it's meant to indicate the maximum
possible number of entries in the MPC table. With your __initdata
suggestion above, it doesn't matter anyway - all the mem we use
will be freed.
 
>> +#define        MP_TRANSLATION  192
> 
> Where does this value (192) come from, and the

Reverse engineering. You're right - a comment would be appropriate.
Fixed.

A patch is attached below to fix these issues, plus one other bit
of idiocy I found - I'd accidentally reduced the number of 
MAX_IRQ_SOURCES (I think I pulled the change forward from
an older kernel, and dropped someone's fix. Oops).

----------------------------------------------------------------------------------------

diff -urN linux-2.4.13-mpparse.3/arch/i386/kernel/mpparse.c linux-2.4.13-mpparse.4/arch/i386/kernel/mpparse.c
--- linux-2.4.13-mpparse.3/arch/i386/kernel/mpparse.c	Fri Oct 26 11:25:46 2001
+++ linux-2.4.13-mpparse.4/arch/i386/kernel/mpparse.c	Fri Oct 26 10:52:29 2001
@@ -126,7 +126,7 @@
  * doing this ....
  */
 static int mpc_record; 
-static struct mpc_config_translation *translation_table[MAX_MPC_ENTRY];
+static struct mpc_config_translation *translation_table[MAX_MPC_ENTRY] __initdata;
 
 static void __init MP_processor_info (struct mpc_config_processor *m)
 {
@@ -320,7 +320,8 @@
 
 	if (mpc_record >= MAX_MPC_ENTRY) 
 		printk("MAX_MPC_ENTRY exceeded!\n");
-	translation_table[mpc_record] = m; /* stash this for later */
+	else
+		translation_table[mpc_record] = m; /* stash this for later */
 }
 
 /*
@@ -333,7 +334,7 @@
 	int count = sizeof (*oemtable); /* the header size */
 	unsigned char *oemptr = ((unsigned char *)oemtable)+count;
 	
-	printk("Found an OEM MPC table at %08lx - parsing it ... \n", (u_long) oemtable);
+	printk("Found an OEM MPC table at %8p - parsing it ... \n", oemtable);
 	if (memcmp(oemtable->oem_signature,MPC_OEM_SIGNATURE,4))
 	{
 		printk("SMP mpc oemtable: bad signature [%c%c%c%c]!\n",
diff -urN linux-2.4.13-mpparse.3/include/asm-i386/mpspec.h linux-2.4.13-mpparse.4/include/asm-i386/mpspec.h
--- linux-2.4.13-mpparse.3/include/asm-i386/mpspec.h	Fri Oct 26 11:25:46 2001
+++ linux-2.4.13-mpparse.4/include/asm-i386/mpspec.h	Fri Oct 26 10:20:22 2001
@@ -61,7 +61,7 @@
 #define	MP_IOAPIC	2
 #define	MP_INTSRC	3
 #define	MP_LINTSRC	4
-#define	MP_TRANSLATION  192
+#define	MP_TRANSLATION  192  /* Used by IBM NUMA-Q to describe node locality */
 
 struct mpc_config_processor
 {
@@ -187,7 +187,7 @@
 #ifdef CONFIG_MULTIQUAD
 #define MAX_IRQ_SOURCES 512
 #else /* !CONFIG_MULTIQUAD */
-#define MAX_IRQ_SOURCES 128
+#define MAX_IRQ_SOURCES 256
 #endif /* CONFIG_MULTIQUAD */
 
 #define MAX_MP_BUSSES 32




