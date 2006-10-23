Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWJWRSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWJWRSf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 13:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWJWRSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 13:18:35 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:38015 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932168AbWJWRSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 13:18:34 -0400
Date: Mon, 23 Oct 2006 10:20:09 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Om Narasimhan" <om.turyx@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPET : Legacy Route replacement patch.
Message-Id: <20061023102009.fc352b60.randy.dunlap@oracle.com>
In-Reply-To: <6b4e42d10610230155w3d10f190w2d955f527a70393d@mail.gmail.com>
References: <6b4e42d10610230155w3d10f190w2d955f527a70393d@mail.gmail.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Oct 2006 01:55:02 -0700 Om Narasimhan wrote:

> HI,
> This patch enables the legacy routing replacement capabilities of the HPET.
> 
> HPET spec is available at www.intel.com/technology/architecture/hpetspec.htm
> 
> Background : HPET is capable of replacing the IRQ0 (connected INT0
> PIN) timer interrupt. The capability register (at offset 0 of HPET
> base address) has a bit specifying if HPET chip is capbale of doing
> this. OS can read the bit either from HW or ACPI table. (HPET ACPI
> description table -> Event Timer block -> bit 15, page 30 of HPET
> spec).  Ideally, I think BIOS should set the ACPI table than letting
> the OS read H/W, which gives the BIOS a way to configure either legacy
> or Legacy replacement modes.
> 
> But a number of bioses (both phoenix and AMI) are not working as
> expected. So I have provided a command line parameter which overrides
> the BIOS ACPI entry. So, irrespctive of the BIOS' HPET ACPI Descriptor
> table settings, if the parameter hpet_lrr=[0,1] is specified, it takes
> precedence.

The "hpet_lrr" parameter needs to be documented in
Documentation/kernel-parameters.txt.

> It seems, some other chipsets (CK-804) has a timing problem, as a
> result of which the machine hangs. In this case, I have passed the
> parameter lpj=<approx bogomips value * 500> which solves this issue. I
> am investigating into this further and would try fixing it.

so what machines (BIOSen) do HPET legacy route replacement
correctly?  (as far as you know)

> Even though compile tested, on 2.6.19-XX I have not tested this patch.
> I ran this on 2.6.16-rc5, which is the latest version that runs on my
> machine (sunfire 4600).
> 
> Patch here...
> 
> Signed-off-by: Om Narasimhan <om.turyx@gmail.com>
> 
> ----
> 
>  arch/i386/kernel/acpi/boot.c |   13 +++++++++++++
>  arch/i386/kernel/time_hpet.c |    3 ++-
>  arch/x86_64/kernel/time.c    |   15 +++++++++++++--
>  include/asm-x86_64/hpet.h    |    1 +
>  include/linux/acpi.h         |    1 +
>  5 files changed, 30 insertions(+), 3 deletions(-)
>  arch/i386/kernel/acpi/boot.c |   13 +++++++++++++
>  arch/i386/kernel/time_hpet.c |    3 ++-
>  arch/x86_64/kernel/time.c    |   15 +++++++++++++--
>  include/asm-x86_64/hpet.h    |    1 +
>  include/linux/acpi.h         |    1 +
>  5 files changed, 30 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
> index ab974ff..228d2b5 100644
> --- a/arch/i386/kernel/acpi/boot.c
> +++ b/arch/i386/kernel/acpi/boot.c
> @@ -82,6 +82,15 @@ EXPORtested  T_SYMBOL(acpi_strict);
>  acpi_interrupt_flags acpi_sci_flags __initdata;
>  int acpi_sci_override_gsi __initdata;
>  int acpi_skip_timer_override __initdata;
> +int acpi_hpet_lrr;	/* the HPET Legacy routing replacement option
> passed through ACPI Table */
> +int hpet_lrr_force;	/* cmdlinetested  opt. for faulty bioses not
> setting ACPI HPET entry right */

Lines too long, please limit to < 80 characters each.

> +static int hpet_lrr_setup (char *str)
> +{
> +	get_option(&str,&hpet_lrr_force);

space after comma, please.

> +	return 1;
> +}
> +__setup ("hpet_lrr=", hpet_lrr_setup);
> 
>  #ifdef CONFIG_X86_LOCAL_APIC
>  static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
> @@ -669,6 +678,10 @@ #define HPET_RESOURCE_NAME_SIZE 9
>  			 "HPET %u", hpet_tbl->number);
>  		hpet_res->end = (1 * 1024) - 1;
>  	}
> +	acpi_hpet_lrr = (hpet_tbl->id & ACPI_HPET_LRR_CAP) ? 1 : 0;
> +	/* Print a message to warn about the bios BUG if HPET ACPI is not
> correctly populated */
> +	printk(KERN_INFO PREFIX "HPET id: %#x. ACPI LRR bit %s SET\n",
> +			hpet_tbl->id, acpi_hpet_lrr ? "": "NOT");
> 
>  #ifdef	CONFIG_X86_64
>  	vxtime.hpet_address = hpet_tbl->addr.addrl |

> diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> index 1ba5a44..3417c0f 100644
> --- a/arch/x86_64/kernel/time.c
> +++ b/arch/x86_64/kernel/time.c
> @@ -48,6 +48,8 @@ static void cpufreq_delayed_get(void);
>  #endif
>  extern void i8254_timer_resume(void);
>  extern int using_apic_timer;
> +extern int acpi_hpet_lrr;
> +extern int hpet_lrr_force;

All of these externs (not just the added ones) should be in some
header file which is #included here.

>  static char *timename = NULL;
> 

> @@ -924,7 +934,8 @@ #endif
>  	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
>  	vxtime.last_tsc = get_cycles_sync();
>  	set_cyc2ns_scale(cpu_khz);
> -	setup_irq(0, &irq0);
> +	printk (KERN_WARNING PREFIX "Registering Timer IRQ = %d\n", timer_irq);

No space between function name and '('.

> +	setup_irq(timer_irq, &irq0);
>  	hotcpu_notifier(time_cpu_notifier, 0);
>  	time_cpu_notifier(NULL, CPU_ONLINE, (void *)(long)smp_processor_id());
> 

> diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
> index ab974ff..228d2b5 100644
> --- a/arch/i386/kernel/acpi/boot.c
> +++ b/arch/i386/kernel/acpi/boot.c
> @@ -82,6 +82,15 @@ EXPORtested  T_SYMBOL(acpi_strict);
>  acpi_interrupt_flags acpi_sci_flags __initdata;
>  int acpi_sci_override_gsi __initdata;
>  int acpi_skip_timer_override __initdata;
> +int acpi_hpet_lrr;	/* the HPET Legacy routing replacement option
> passed through ACPI Table */
> +int hpet_lrr_force;	/* cmdlinetested  opt. for faulty bioses not
> setting ACPI HPET entry right */

Lines too long...

> +static int hpet_lrr_setup (char *str)
> +{
> +	get_option(&str,&hpet_lrr_force);
> +	return 1;
> +}
> +__setup ("hpet_lrr=", hpet_lrr_setup);
> 
>  #ifdef CONFIG_X86_LOCAL_APIC
>  static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
> @@ -669,6 +678,10 @@ #define HPET_RESOURCE_NAME_SIZE 9
>  			 "HPET %u", hpet_tbl->number);
>  		hpet_res->end = (1 * 1024) - 1;
>  	}
> +	acpi_hpet_lrr = (hpet_tbl->id & ACPI_HPET_LRR_CAP) ? 1 : 0;
> +	/* Print a message to warn about the bios BUG if HPET ACPI is not
> correctly populated */

Line wrap, MUA problem?  When joined into one line, the line is
too long.  Please limit lines to < 80 characters each.

Several instances of this, causing "malformed patch" messages
from patch:
patch: **** malformed patch at line 58: passed through ACPI Table */

> +	printk(KERN_INFO PREFIX "HPET id: %#x. ACPI LRR bit %s SET\n",
> +			hpet_tbl->id, acpi_hpet_lrr ? "": "NOT");
> 
>  #ifdef	CONFIG_X86_64
>  	vxtime.hpet_address = hpet_tbl->addr.addrl |

> diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> index 1ba5a44..3417c0f 100644
> --- a/arch/x86_64/kernel/time.c
> +++ b/arch/x86_64/kernel/time.c
> @@ -48,6 +48,8 @@ static void cpufreq_delayed_get(void);
>  #endif
>  extern void i8254_timer_resume(void);
>  extern int using_apic_timer;
> +extern int acpi_hpet_lrr;
> +extern int hpet_lrr_force;

Put externs into a header file and include that file.

>  static char *timename = NULL;
> 

> @@ -924,7 +934,8 @@ #endif
>  	vxtime.tsc_quot = (USEC_PER_MSEC << US_SCALE) / cpu_khz;
>  	vxtime.last_tsc = get_cycles_sync();
>  	set_cyc2ns_scale(cpu_khz);
> -	setup_irq(0, &irq0);
> +	printk (KERN_WARNING PREFIX "Registering Timer IRQ = %d\n", timer_irq);

no space between printk and (

> +	setup_irq(timer_irq, &irq0);
>  	hotcpu_notifier(time_cpu_notifier, 0);
>  	time_cpu_notifier(NULL, CPU_ONLINE, (void *)(long)smp_processor_id());
> 

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 2b0c955..62dab08 100644
> --- a/include/linux/acpi.h arch/i386/kernel/acpi/boot.c |   13 +++++++++++++
>  arch/i386/kernel/time_hpet.c |    3 ++-
>  arch/x86_64/kernel/time.c    |   15 +++++++++++++--
>  include/asm-x86_64/hpet.h    |    1 +
>  include/linux/acpi.h         |    1 +
>  5 files changed, 30 insertions(+), 3 deletions(-)

??? more malformed patch...

> diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
> index ab974ff..228d2b5 100644
> --- a/arch/i386/kernel/acpi/boot.c
> +++ b/arch/i386/kernel/acpi/boot.c
> @@ -82,6 +82,15 @@ EXPORtested  T_SYMBOL(acpi_strict);
>  acpi_interrupt_flags acpi_sci_flags __initdata;
>  int acpi_sci_override_gsi __initdata;
>  int acpi_skip_timer_override __initdata;
> +int acpi_hpet_lrr;	/* the HPET Legacy routing replacement option
> passed through ACPI Table */
> +int hpet_lrr_force;	/* cmdlinetested  opt. for faulty bioses not
> setting ACPI HPET entry right */

Lines too long.

> +static int hpet_lrr_setup (char *str)
> +{
> +	get_option(&str,&hpet_lrr_force);

space after comma, please.

> +	return 1;
> +}
> +__setup ("hpet_lrr=", hpet_lrr_setup);
> 
>  #ifdef CONFIG_X86_LOCAL_APIC
>  static u64 acpi_lapic_addr __initdata = APIC_DEFAULT_PHYS_BASE;
> @@ -669,6 +678,10 @@ #define HPET_RESOURCE_NAME_SIZE 9
>  			 "HPET %u", hpet_tbl->number);
>  		hpet_res->end = (1 * 1024) - 1;
>  	}
> +	acpi_hpet_lrr = (hpet_tbl->id & ACPI_HPET_LRR_CAP) ? 1 : 0;
> +	/* Print a message to warn about the bios BUG if HPET ACPI is not
> correctly populated */
> +	printk(KERN_INFO PREFIX "HPET id: %#x. ACPI LRR bit %s SET\n",
> +			hpet_tbl->id, acpi_hpet_lrr ? "": "NOT");
> 
>  #ifdef	CONFIG_X86_64
>  	vxtime.hpet_address = hpet_tbl->addr.addrl |

> diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> index 1ba5a44..3417c0f 100644
> --- a/arch/x86_64/kernel/time.c
> +++ b/arch/x86_64/kernel/time.c
> @@ -48,6 +48,8 @@ static void cpufreq_delayed_get(void);
>  #endif
>  extern void i8254_timer_resume(void);
>  extern int using_apic_timer;
> +extern int acpi_hpet_lrr;
> +extern int hpet_lrr_force;

use some header file for these.

>  static char *timename = NULL;
> 

> @@ -887,6 +892,7 @@ time_cpu_notifier(struct notifier_block
> 
>  void __init time_init(void)
>  {
> +	int timer_irq = 0;
>  	if (nohpet)
>  		vxtime.hpet_address = 0;
> 

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 2b0c955..62dab08 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -220,6 +220,7 @@ enum acpi_interrupt_id {
>  };
> 
>  #define	ACPI_SPACE_MEM		0
> +#define	ACPI_HPET_LRR_CAP	0x8000
> 
>  struct acpi_gen_regaddr {
>  	u8  space_id;

some kind of diff header corruption here?  Missing a few lines:

> +++ b/include/linux/acpi.h
> @@ -220,6 +220,7 @@ enum acpi_interrupt_id {
>  };
> 
>  #define	ACPI_SPACE_MEM		0
> +#define	ACPI_HPET_LRR_CAP	0x8000
> 
>  struct acpi_gen_regaddr {
>  	u8  space_id;
> -


---
~Randy
