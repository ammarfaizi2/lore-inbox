Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278666AbRJZQB0>; Fri, 26 Oct 2001 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278694AbRJZQBH>; Fri, 26 Oct 2001 12:01:07 -0400
Received: from air-1.osdl.org ([65.201.151.5]:24335 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S278666AbRJZQBE>;
	Fri, 26 Oct 2001 12:01:04 -0400
Message-ID: <3BD98768.6A99BD80@osdl.org>
Date: Fri, 26 Oct 2001 08:55:20 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-20mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <fletch@aracnet.com>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Patch to read/parse the MPC oem tables
In-Reply-To: <3298454519.1004025834@[10.10.1.2]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin-

Overall this looks like a mostly-clean patch.

Questions and comments below.

~Randy


"Martin J. Bligh" wrote:
> 
> This patch will parse the OEM extensions to the mps tables
> (if present). This gives me a mapping to tell which device
> lies in which NUMA node (the current code just guesses).

So these extensions are OEM-specific, not part of the MP spec,
right?


> Patch is against 2.4.13 - if it looks OK, please could you add it?

> diff -urN virgin-2.4.13/arch/i386/kernel/mpparse.c linux-2.4.13/arch/i386/kernel/mpparse.c
> --- virgin-2.4.13/arch/i386/kernel/mpparse.c    Thu Oct  4 18:42:54 2001
> +++ linux-2.4.13/arch/i386/kernel/mpparse.c     Thu Oct 25 10:13:18 2001
> @@ -118,18 +120,37 @@
> +static int mpc_record;
> +static struct mpc_config_translation *translation_table[MAX_MPC_ENTRY];

Could this array be __initdata or reduced in size some,
for people who don't need it?  (more about this below)
E.g., I bet most people don't need this static 4 KB array.

Also, could the array of structs <mp_irqs and mp_ioapics> (in
mpparse.c) be made __initdata, so that they could be discarded
after init?
I tested this idea (without this patch, just by changing
mp_irqs[] and mp_ioapics[] to __initdata, and it booted OK,
and they are put into the .data.init section according to
objdump.  Are there some other/different problems doing this, anyone?
OTOH, with a 16 GB system, you won't worry much about saving a few KB,
eh?


> @@ -286,6 +313,62 @@
> 
> +static void __init MP_translation_info (struct mpc_config_translation *m)
> +{
> +       printk("Translation: record %d, type %d, quad %d, global %d, local %d\n", mpc_record, m->trans_type,
> +               m->trans_quad, m->trans_global, m->trans_local);
> +
> +       if (mpc_record >= MAX_MPC_ENTRY)
> +               printk("MAX_MPC_ENTRY exceeded!\n");

Add "else" here to keep from stepping out of the array bounds.

> +       translation_table[mpc_record] = m; /* stash this for later */
> +}
> +
> +/*
> + * Read/parse the MPC oem tables
> + */
> +
> +static void __init smp_read_mpc_oem(struct mp_config_oemtable *oemtable, \
> +       unsigned short oemsize)
> +{
> +       int count = sizeof (*oemtable); /* the header size */
> +       unsigned char *oemptr = ((unsigned char *)oemtable)+count;
> +
> +       printk("Found an OEM MPC table at %08lx - parsing it ... \n", (u_long) oemtable);

BTW, "%p" prints pointers also, without casting them.

> +       while (count < oemtable->oem_length) {
> +               switch (*oemptr) {
> +                       case MP_TRANSLATION:
> +                       {
> +                               struct mpc_config_translation *m=
> +                                       (struct mpc_config_translation *)oemptr;
> +                               MP_translation_info(m);
> +                               oemptr += sizeof(*m);
> +                               count += sizeof(*m);
> +                               ++mpc_record;
> +                               break;
> +                       }

>  /*
>   * Read/parse the MPC
>   */
> @@ -330,6 +413,13 @@
>         /* save the local APIC address, it might be non-default */
>         mp_lapic_addr = mpc->mpc_lapic;
> 
> +       if (clustered_apic_mode && mpc->mpc_oemptr) {
> +               /* We need to process the oem mpc tables to tell us which quad things are in ... */
> +               mpc_record = 0;
> +               smp_read_mpc_oem((struct mp_config_oemtable *) mpc->mpc_oemptr, mpc->mpc_oemsize);
> +               mpc_record = 0;

What's this =0 for?

> @@ -381,7 +471,13 @@
>                                 count+=sizeof(*m);
>                                 break;
>                         }
> +                       default:
> +                       {
> +                               count = mpc->mpc_length;
> +                               break;
> +                       }
>                 }
> +               ++mpc_record;

And what's this increment for?

> diff -urN virgin-2.4.13/include/asm-i386/mpspec.h linux-2.4.13/include/asm-i386/mpspec.h
> --- virgin-2.4.13/include/asm-i386/mpspec.h     Thu Oct  4 18:42:54 2001
> +++ linux-2.4.13/include/asm-i386/mpspec.h      Thu Oct 25 14:31:12 2001
> @@ -16,7 +16,13 @@
>  /*
>   * a maximum of 16 APICs with the current APIC ID architecture.
>   */
> +#ifdef CONFIG_MULTIQUAD
> +#define MAX_APICS 256
> +#else /* !CONFIG_MULTIQUAD */
>  #define MAX_APICS 16
> +#endif /* CONFIG_MULTIQUAD */
> +
> +#define MAX_MPC_ENTRY 1024

How about #defining MAX_MPC_ENTRY above here (depending on MULTIQUAD),
so that it can be smaller for non-MULTIQUAD targets?

> @@ -55,6 +61,7 @@
>  #define        MP_IOAPIC       2
>  #define        MP_INTSRC       3
>  #define        MP_LINTSRC      4
> +#define        MP_TRANSLATION  192

Where does this value (192) come from, and the
mpc_config_oemtable and mpc_config_translation structs?
Not in the MP 1.4 spec, right?  (yes, I searched)
So maybe some comment about it being used by IBM would
be good (or even qualified by CONFIG_MULTIQUAD somehow;
that would be easy in the .h file, but not so easy
in mpparse.c -- without being ugly).

Or is it some de facto standard?
Is it used by other large-systems manufacturers for the
same purpose?

> @@ -144,6 +151,27 @@
> +struct mp_config_oemtable
> +{
> +       char oem_signature[4];
> +#define MPC_OEM_SIGNATURE "_OEM"
> +       unsigned short oem_length;      /* Size of table */
> +       char  oem_rev;                  /* 0x01 */
> +       char  oem_checksum;
> +       char  mpc_oem[8];
> +};
> +
> +struct mpc_config_translation
> +{
> +        unsigned char mpc_type;
> +        unsigned char trans_len;
> +        unsigned char trans_type;
> +        unsigned char trans_quad;
> +        unsigned char trans_global;
> +        unsigned char trans_local;
> +        unsigned short trans_reserved;
> +};
