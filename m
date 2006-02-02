Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423452AbWBBK1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423452AbWBBK1e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 05:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423451AbWBBK1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 05:27:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7953 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1423450AbWBBK1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 05:27:32 -0500
Date: Thu, 2 Feb 2006 10:27:21 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org,
       takata@linux-m32r.org, pfg@sgi.com
Subject: Re: [CFT] Don't use ASYNC_* nor SERIAL_IO_* with serial_core
Message-ID: <20060202102721.GE5034@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-mips@linux-mips.org, linuxppc-dev@ozlabs.org,
	takata@linux-m32r.org, pfg@sgi.com
References: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121211407.GA19984@dyn-67.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ping?

On Sat, Jan 21, 2006 at 09:14:07PM +0000, Russell King wrote:
> The serial_core layer has its own definitions for these, and I'd
> appreciate it if folk would use them instead of the old ASYNC_* and
> SERIAL_IO_* definitions.
> 
> They're compatible _at the moment_ but I make no guarantees that they
> will stay that way.  Hence, it's in your interest to ensure that you're
> using the correct definitions.
> 
> MIPS, PPC seem to be the architectures which are stuck in the past on
> this issue, as is the M32R SIO driver.
> 
> The ioc4_serial driver is worse.  It assumes that it can set/clear
> ASYNC_CTS_FLOW in the uart_info flags field, which is private to
> serial_core.  It also seems to set TTY_IO_ERROR followed by immediately
> clearing it (pointless), and then it writes to tty->alt_speed... which
> isn't used by the serial layer so is also pointless.
> 
> So, here's a patch to fix some of this crap up.  Please test and
> enjoy - I certainly didn't.
> 
>  arch/mips/cobalt/setup.c                   |    2 +-
>  arch/mips/lasat/setup.c                    |    4 ++--
>  arch/mips/mips-boards/atlas/atlas_setup.c  |    4 ++--
>  arch/mips/mips-boards/sead/sead_setup.c    |    4 ++--
>  arch/mips/mips-boards/sim/sim_setup.c      |    4 ++--
>  arch/mips/momentum/jaguar_atx/ja-console.c |    2 +-
>  arch/mips/pmc-sierra/yosemite/setup.c      |    2 +-
>  arch/mips/sgi-ip32/ip32-setup.c            |   13 ++++---------
>  arch/ppc/platforms/4xx/bamboo.c            |    4 ++--
>  arch/ppc/platforms/4xx/bubinga.c           |    4 ++--
>  arch/ppc/platforms/4xx/ebony.c             |    4 ++--
>  arch/ppc/platforms/4xx/luan.c              |    4 ++--
>  arch/ppc/platforms/4xx/ocotea.c            |    4 ++--
>  arch/ppc/platforms/4xx/xilinx_ml300.c      |    4 ++--
>  arch/ppc/platforms/4xx/yucca.c             |    4 ++--
>  arch/ppc/platforms/spruce.c                |    4 ++--
>  drivers/serial/ioc4_serial.c               |   14 --------------
>  drivers/serial/m32r_sio.c                  |    2 +-
>  18 files changed, 32 insertions(+), 51 deletions(-)
> 
> diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
> --- a/arch/mips/cobalt/setup.c
> +++ b/arch/mips/cobalt/setup.c
> @@ -139,7 +139,7 @@ void __init plat_setup(void)
>  		uart.type	= PORT_UNKNOWN;
>  		uart.uartclk	= 18432000;
>  		uart.irq	= COBALT_SERIAL_IRQ;
> -		uart.flags	= STD_COM_FLAGS;
> +		uart.flags	= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  		uart.iobase	= 0xc800000;
>  		uart.iotype	= UPIO_PORT;
>  
> diff --git a/arch/mips/lasat/setup.c b/arch/mips/lasat/setup.c
> --- a/arch/mips/lasat/setup.c
> +++ b/arch/mips/lasat/setup.c
> @@ -134,8 +134,8 @@ void __init serial_init(void)
>  
>  	memset(&s, 0, sizeof(s));
>  
> -	s.flags = STD_COM_FLAGS;
> -	s.iotype = SERIAL_IO_MEM;
> +	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
> +	s.iotype = UPIO_MEM;
>  
>  	if (mips_machtype == MACH_LASAT_100) {
>  		s.uartclk = LASAT_BASE_BAUD_100 * 16;
> diff --git a/arch/mips/mips-boards/atlas/atlas_setup.c b/arch/mips/mips-boards/atlas/atlas_setup.c
> --- a/arch/mips/mips-boards/atlas/atlas_setup.c
> +++ b/arch/mips/mips-boards/atlas/atlas_setup.c
> @@ -82,8 +82,8 @@ static void __init serial_init(void)
>  #endif
>  	s.irq = ATLASINT_UART;
>  	s.uartclk = ATLAS_BASE_BAUD * 16;
> -	s.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ;
> -	s.iotype = SERIAL_IO_PORT;
> +	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_AUTO_IRQ;
> +	s.iotype = UPIO_PORT;
>  	s.regshift = 3;
>  
>  	if (early_serial_setup(&s) != 0) {
> diff --git a/arch/mips/mips-boards/sead/sead_setup.c b/arch/mips/mips-boards/sead/sead_setup.c
> --- a/arch/mips/mips-boards/sead/sead_setup.c
> +++ b/arch/mips/mips-boards/sead/sead_setup.c
> @@ -71,8 +71,8 @@ static void __init serial_init(void)
>  #endif
>  	s.irq = MIPSCPU_INT_BASE + MIPSCPU_INT_UART0;
>  	s.uartclk = SEAD_BASE_BAUD * 16;
> -	s.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ;
> -	s.iotype = 0;
> +	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_AUTO_IRQ;
> +	s.iotype = UPIO_PORT;
>  	s.regshift = 3;
>  
>  	if (early_serial_setup(&s) != 0) {
> diff --git a/arch/mips/mips-boards/sim/sim_setup.c b/arch/mips/mips-boards/sim/sim_setup.c
> --- a/arch/mips/mips-boards/sim/sim_setup.c
> +++ b/arch/mips/mips-boards/sim/sim_setup.c
> @@ -88,8 +88,8 @@ static void __init serial_init(void)
>  	 but poll for now */
>  	s.irq =  0;
>  	s.uartclk = BASE_BAUD * 16;
> -	s.flags = ASYNC_BOOT_AUTOCONF | UPF_SKIP_TEST;
> -	s.iotype = SERIAL_IO_PORT | ASYNC_SKIP_TEST;
> +	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
> +	s.iotype = UPIO_PORT;
>  	s.regshift = 0;
>  	s.timeout = 4;
>  
> diff --git a/arch/mips/momentum/jaguar_atx/ja-console.c b/arch/mips/momentum/jaguar_atx/ja-console.c
> --- a/arch/mips/momentum/jaguar_atx/ja-console.c
> +++ b/arch/mips/momentum/jaguar_atx/ja-console.c
> @@ -93,7 +93,7 @@ static void inline ja_console_probe(void
>  	up.uartclk	= JAGUAR_ATX_UART_CLK;
>  	up.regshift	= 2;
>  	up.iotype	= UPIO_MEM;
> -	up.flags	= ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	up.flags	= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	up.line		= 0;
>  
>  	if (early_serial_setup(&up))
> diff --git a/arch/mips/pmc-sierra/yosemite/setup.c b/arch/mips/pmc-sierra/yosemite/setup.c
> --- a/arch/mips/pmc-sierra/yosemite/setup.c
> +++ b/arch/mips/pmc-sierra/yosemite/setup.c
> @@ -185,7 +185,7 @@ static void __init py_uart_setup(void)
>  	up.uartclk      = TITAN_UART_CLK;
>  	up.regshift     = 0;
>  	up.iotype       = UPIO_MEM;
> -	up.flags        = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	up.flags        = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	up.line         = 0;
>  
>  	if (early_serial_setup(&up))
> diff --git a/arch/mips/sgi-ip32/ip32-setup.c b/arch/mips/sgi-ip32/ip32-setup.c
> --- a/arch/mips/sgi-ip32/ip32-setup.c
> +++ b/arch/mips/sgi-ip32/ip32-setup.c
> @@ -66,11 +66,6 @@ static inline void str2eaddr(unsigned ch
>  #include <linux/tty.h>
>  #include <linux/serial.h>
>  #include <linux/serial_core.h>
> -extern int early_serial_setup(struct uart_port *port);
> -
> -#define STD_COM_FLAGS (ASYNC_SKIP_TEST)
> -#define BASE_BAUD (1843200 / 16)
> -
>  #endif /* CONFIG_SERIAL_8250 */
>  
>  /* An arbitrary time; this can be decreased if reliability looks good */
> @@ -110,8 +105,8 @@ void __init plat_setup(void)
>  		o2_serial[0].type	= PORT_16550A;
>  		o2_serial[0].line	= 0;
>  		o2_serial[0].irq	= MACEISA_SERIAL1_IRQ;
> -		o2_serial[0].flags	= STD_COM_FLAGS;
> -		o2_serial[0].uartclk	= BASE_BAUD * 16;
> +		o2_serial[0].flags	= UPF_SKIP_TEST;
> +		o2_serial[0].uartclk	= 1843200;
>  		o2_serial[0].iotype	= UPIO_MEM;
>  		o2_serial[0].membase	= (char *)&mace->isa.serial1;
>  		o2_serial[0].fifosize	= 14;
> @@ -121,8 +116,8 @@ void __init plat_setup(void)
>  		o2_serial[1].type	= PORT_16550A;
>  		o2_serial[1].line	= 1;
>  		o2_serial[1].irq	= MACEISA_SERIAL2_IRQ;
> -		o2_serial[1].flags	= STD_COM_FLAGS;
> -		o2_serial[1].uartclk	= BASE_BAUD * 16;
> +		o2_serial[1].flags	= UPF_SKIP_TEST;
> +		o2_serial[1].uartclk	= 1843200;
>  		o2_serial[1].iotype	= UPIO_MEM;
>  		o2_serial[1].membase	= (char *)&mace->isa.serial2;
>  		o2_serial[1].fifosize	= 14;
> diff --git a/arch/ppc/platforms/4xx/bamboo.c b/arch/ppc/platforms/4xx/bamboo.c
> --- a/arch/ppc/platforms/4xx/bamboo.c
> +++ b/arch/ppc/platforms/4xx/bamboo.c
> @@ -332,8 +332,8 @@ bamboo_early_serial_map(void)
>  	port.irq = 0;
>  	port.uartclk = clocks.uart0;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/bubinga.c b/arch/ppc/platforms/4xx/bubinga.c
> --- a/arch/ppc/platforms/4xx/bubinga.c
> +++ b/arch/ppc/platforms/4xx/bubinga.c
> @@ -97,8 +97,8 @@ bubinga_early_serial_map(void)
>  	port.irq = ACTING_UART0_INT;
>  	port.uartclk = uart_clock;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/ebony.c b/arch/ppc/platforms/4xx/ebony.c
> --- a/arch/ppc/platforms/4xx/ebony.c
> +++ b/arch/ppc/platforms/4xx/ebony.c
> @@ -225,8 +225,8 @@ ebony_early_serial_map(void)
>  	port.irq = 0;
>  	port.uartclk = clocks.uart0;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/luan.c b/arch/ppc/platforms/4xx/luan.c
> --- a/arch/ppc/platforms/4xx/luan.c
> +++ b/arch/ppc/platforms/4xx/luan.c
> @@ -279,8 +279,8 @@ luan_early_serial_map(void)
>  	port.irq = UART0_INT;
>  	port.uartclk = clocks.uart0;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
> --- a/arch/ppc/platforms/4xx/ocotea.c
> +++ b/arch/ppc/platforms/4xx/ocotea.c
> @@ -248,8 +248,8 @@ ocotea_early_serial_map(void)
>  	port.irq = UART0_INT;
>  	port.uartclk = clocks.uart0;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.c b/arch/ppc/platforms/4xx/xilinx_ml300.c
> --- a/arch/ppc/platforms/4xx/xilinx_ml300.c
> +++ b/arch/ppc/platforms/4xx/xilinx_ml300.c
> @@ -95,8 +95,8 @@ ml300_early_serial_map(void)
>  		port.irq = old_ports[i].irq;
>  		port.uartclk = old_ports[i].baud_base * 16;
>  		port.regshift = old_ports[i].iomem_reg_shift;
> -		port.iotype = SERIAL_IO_MEM;
> -		port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +		port.iotype = UPIO_MEM;
> +		port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  		port.line = i;
>  
>  		if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
> --- a/arch/ppc/platforms/4xx/yucca.c
> +++ b/arch/ppc/platforms/4xx/yucca.c
> @@ -305,8 +305,8 @@ yucca_early_serial_map(void)
>  	port.irq = UART0_INT;
>  	port.uartclk = clocks.uart0;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/spruce.c b/arch/ppc/platforms/spruce.c
> --- a/arch/ppc/platforms/spruce.c
> +++ b/arch/ppc/platforms/spruce.c
> @@ -176,8 +176,8 @@ spruce_early_serial_map(void)
>  	memset(&serial_req, 0, sizeof(serial_req));
>  	serial_req.uartclk = uart_clk;
>  	serial_req.irq = UART0_INT;
> -	serial_req.flags = ASYNC_BOOT_AUTOCONF;
> -	serial_req.iotype = SERIAL_IO_MEM;
> +	serial_req.flags = UPF_BOOT_AUTOCONF;
> +	serial_req.iotype = UPIO_MEM;
>  	serial_req.membase = (u_char *)UART0_IO_BASE;
>  	serial_req.regshift = 0;
>  
> diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
> --- a/drivers/serial/ioc4_serial.c
> +++ b/drivers/serial/ioc4_serial.c
> @@ -1717,11 +1717,9 @@ ioc4_change_speed(struct uart_port *the_
>  	}
>  
>  	if (cflag & CRTSCTS) {
> -		info->flags |= ASYNC_CTS_FLOW;
>  		port->ip_sscr |= IOC4_SSCR_HFC_EN;
>  	}
>  	else {
> -		info->flags &= ~ASYNC_CTS_FLOW;
>  		port->ip_sscr &= ~IOC4_SSCR_HFC_EN;
>  	}
>  	writel(port->ip_sscr, &port->ip_serial_regs->sscr);
> @@ -1760,18 +1758,6 @@ static inline int ic4_startup_local(stru
>  
>  	info = the_port->info;
>  
> -	if (info->tty) {
> -		set_bit(TTY_IO_ERROR, &info->tty->flags);
> -		clear_bit(TTY_IO_ERROR, &info->tty->flags);
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
> -			info->tty->alt_speed = 57600;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
> -			info->tty->alt_speed = 115200;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
> -			info->tty->alt_speed = 230400;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
> -			info->tty->alt_speed = 460800;
> -	}
>  	local_open(port);
>  
>  	/* set the speed of the serial port */
> diff --git a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
> --- a/drivers/serial/m32r_sio.c
> +++ b/drivers/serial/m32r_sio.c
> @@ -80,7 +80,7 @@
>  #include <asm/serial.h>
>  
>  /* Standard COM flags */
> -#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
> +#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST)
>  
>  /*
>   * SERIAL_PORT_DFNS tells us about built-in ports that have no

> diff --git a/arch/mips/cobalt/setup.c b/arch/mips/cobalt/setup.c
> --- a/arch/mips/cobalt/setup.c
> +++ b/arch/mips/cobalt/setup.c
> @@ -139,7 +139,7 @@ void __init plat_setup(void)
>  		uart.type	= PORT_UNKNOWN;
>  		uart.uartclk	= 18432000;
>  		uart.irq	= COBALT_SERIAL_IRQ;
> -		uart.flags	= STD_COM_FLAGS;
> +		uart.flags	= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  		uart.iobase	= 0xc800000;
>  		uart.iotype	= UPIO_PORT;
>  
> diff --git a/arch/mips/lasat/setup.c b/arch/mips/lasat/setup.c
> --- a/arch/mips/lasat/setup.c
> +++ b/arch/mips/lasat/setup.c
> @@ -134,8 +134,8 @@ void __init serial_init(void)
>  
>  	memset(&s, 0, sizeof(s));
>  
> -	s.flags = STD_COM_FLAGS;
> -	s.iotype = SERIAL_IO_MEM;
> +	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
> +	s.iotype = UPIO_MEM;
>  
>  	if (mips_machtype == MACH_LASAT_100) {
>  		s.uartclk = LASAT_BASE_BAUD_100 * 16;
> diff --git a/arch/mips/mips-boards/atlas/atlas_setup.c b/arch/mips/mips-boards/atlas/atlas_setup.c
> --- a/arch/mips/mips-boards/atlas/atlas_setup.c
> +++ b/arch/mips/mips-boards/atlas/atlas_setup.c
> @@ -82,8 +82,8 @@ static void __init serial_init(void)
>  #endif
>  	s.irq = ATLASINT_UART;
>  	s.uartclk = ATLAS_BASE_BAUD * 16;
> -	s.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ;
> -	s.iotype = SERIAL_IO_PORT;
> +	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_AUTO_IRQ;
> +	s.iotype = UPIO_PORT;
>  	s.regshift = 3;
>  
>  	if (early_serial_setup(&s) != 0) {
> diff --git a/arch/mips/mips-boards/sead/sead_setup.c b/arch/mips/mips-boards/sead/sead_setup.c
> --- a/arch/mips/mips-boards/sead/sead_setup.c
> +++ b/arch/mips/mips-boards/sead/sead_setup.c
> @@ -71,8 +71,8 @@ static void __init serial_init(void)
>  #endif
>  	s.irq = MIPSCPU_INT_BASE + MIPSCPU_INT_UART0;
>  	s.uartclk = SEAD_BASE_BAUD * 16;
> -	s.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST | ASYNC_AUTO_IRQ;
> -	s.iotype = 0;
> +	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_AUTO_IRQ;
> +	s.iotype = UPIO_PORT;
>  	s.regshift = 3;
>  
>  	if (early_serial_setup(&s) != 0) {
> diff --git a/arch/mips/mips-boards/sim/sim_setup.c b/arch/mips/mips-boards/sim/sim_setup.c
> --- a/arch/mips/mips-boards/sim/sim_setup.c
> +++ b/arch/mips/mips-boards/sim/sim_setup.c
> @@ -88,8 +88,8 @@ static void __init serial_init(void)
>  	 but poll for now */
>  	s.irq =  0;
>  	s.uartclk = BASE_BAUD * 16;
> -	s.flags = ASYNC_BOOT_AUTOCONF | UPF_SKIP_TEST;
> -	s.iotype = SERIAL_IO_PORT | ASYNC_SKIP_TEST;
> +	s.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
> +	s.iotype = UPIO_PORT;
>  	s.regshift = 0;
>  	s.timeout = 4;
>  
> diff --git a/arch/mips/momentum/jaguar_atx/ja-console.c b/arch/mips/momentum/jaguar_atx/ja-console.c
> --- a/arch/mips/momentum/jaguar_atx/ja-console.c
> +++ b/arch/mips/momentum/jaguar_atx/ja-console.c
> @@ -93,7 +93,7 @@ static void inline ja_console_probe(void
>  	up.uartclk	= JAGUAR_ATX_UART_CLK;
>  	up.regshift	= 2;
>  	up.iotype	= UPIO_MEM;
> -	up.flags	= ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	up.flags	= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	up.line		= 0;
>  
>  	if (early_serial_setup(&up))
> diff --git a/arch/mips/pmc-sierra/yosemite/setup.c b/arch/mips/pmc-sierra/yosemite/setup.c
> --- a/arch/mips/pmc-sierra/yosemite/setup.c
> +++ b/arch/mips/pmc-sierra/yosemite/setup.c
> @@ -185,7 +185,7 @@ static void __init py_uart_setup(void)
>  	up.uartclk      = TITAN_UART_CLK;
>  	up.regshift     = 0;
>  	up.iotype       = UPIO_MEM;
> -	up.flags        = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	up.flags        = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	up.line         = 0;
>  
>  	if (early_serial_setup(&up))
> diff --git a/arch/mips/sgi-ip32/ip32-setup.c b/arch/mips/sgi-ip32/ip32-setup.c
> --- a/arch/mips/sgi-ip32/ip32-setup.c
> +++ b/arch/mips/sgi-ip32/ip32-setup.c
> @@ -66,11 +66,6 @@ static inline void str2eaddr(unsigned ch
>  #include <linux/tty.h>
>  #include <linux/serial.h>
>  #include <linux/serial_core.h>
> -extern int early_serial_setup(struct uart_port *port);
> -
> -#define STD_COM_FLAGS (ASYNC_SKIP_TEST)
> -#define BASE_BAUD (1843200 / 16)
> -
>  #endif /* CONFIG_SERIAL_8250 */
>  
>  /* An arbitrary time; this can be decreased if reliability looks good */
> @@ -110,8 +105,8 @@ void __init plat_setup(void)
>  		o2_serial[0].type	= PORT_16550A;
>  		o2_serial[0].line	= 0;
>  		o2_serial[0].irq	= MACEISA_SERIAL1_IRQ;
> -		o2_serial[0].flags	= STD_COM_FLAGS;
> -		o2_serial[0].uartclk	= BASE_BAUD * 16;
> +		o2_serial[0].flags	= UPF_SKIP_TEST;
> +		o2_serial[0].uartclk	= 1843200;
>  		o2_serial[0].iotype	= UPIO_MEM;
>  		o2_serial[0].membase	= (char *)&mace->isa.serial1;
>  		o2_serial[0].fifosize	= 14;
> @@ -121,8 +116,8 @@ void __init plat_setup(void)
>  		o2_serial[1].type	= PORT_16550A;
>  		o2_serial[1].line	= 1;
>  		o2_serial[1].irq	= MACEISA_SERIAL2_IRQ;
> -		o2_serial[1].flags	= STD_COM_FLAGS;
> -		o2_serial[1].uartclk	= BASE_BAUD * 16;
> +		o2_serial[1].flags	= UPF_SKIP_TEST;
> +		o2_serial[1].uartclk	= 1843200;
>  		o2_serial[1].iotype	= UPIO_MEM;
>  		o2_serial[1].membase	= (char *)&mace->isa.serial2;
>  		o2_serial[1].fifosize	= 14;
> diff --git a/arch/ppc/platforms/4xx/bamboo.c b/arch/ppc/platforms/4xx/bamboo.c
> --- a/arch/ppc/platforms/4xx/bamboo.c
> +++ b/arch/ppc/platforms/4xx/bamboo.c
> @@ -332,8 +332,8 @@ bamboo_early_serial_map(void)
>  	port.irq = 0;
>  	port.uartclk = clocks.uart0;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/bubinga.c b/arch/ppc/platforms/4xx/bubinga.c
> --- a/arch/ppc/platforms/4xx/bubinga.c
> +++ b/arch/ppc/platforms/4xx/bubinga.c
> @@ -97,8 +97,8 @@ bubinga_early_serial_map(void)
>  	port.irq = ACTING_UART0_INT;
>  	port.uartclk = uart_clock;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/ebony.c b/arch/ppc/platforms/4xx/ebony.c
> --- a/arch/ppc/platforms/4xx/ebony.c
> +++ b/arch/ppc/platforms/4xx/ebony.c
> @@ -225,8 +225,8 @@ ebony_early_serial_map(void)
>  	port.irq = 0;
>  	port.uartclk = clocks.uart0;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/luan.c b/arch/ppc/platforms/4xx/luan.c
> --- a/arch/ppc/platforms/4xx/luan.c
> +++ b/arch/ppc/platforms/4xx/luan.c
> @@ -279,8 +279,8 @@ luan_early_serial_map(void)
>  	port.irq = UART0_INT;
>  	port.uartclk = clocks.uart0;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/ocotea.c b/arch/ppc/platforms/4xx/ocotea.c
> --- a/arch/ppc/platforms/4xx/ocotea.c
> +++ b/arch/ppc/platforms/4xx/ocotea.c
> @@ -248,8 +248,8 @@ ocotea_early_serial_map(void)
>  	port.irq = UART0_INT;
>  	port.uartclk = clocks.uart0;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.c b/arch/ppc/platforms/4xx/xilinx_ml300.c
> --- a/arch/ppc/platforms/4xx/xilinx_ml300.c
> +++ b/arch/ppc/platforms/4xx/xilinx_ml300.c
> @@ -95,8 +95,8 @@ ml300_early_serial_map(void)
>  		port.irq = old_ports[i].irq;
>  		port.uartclk = old_ports[i].baud_base * 16;
>  		port.regshift = old_ports[i].iomem_reg_shift;
> -		port.iotype = SERIAL_IO_MEM;
> -		port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +		port.iotype = UPIO_MEM;
> +		port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  		port.line = i;
>  
>  		if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/4xx/yucca.c b/arch/ppc/platforms/4xx/yucca.c
> --- a/arch/ppc/platforms/4xx/yucca.c
> +++ b/arch/ppc/platforms/4xx/yucca.c
> @@ -305,8 +305,8 @@ yucca_early_serial_map(void)
>  	port.irq = UART0_INT;
>  	port.uartclk = clocks.uart0;
>  	port.regshift = 0;
> -	port.iotype = SERIAL_IO_MEM;
> -	port.flags = ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST;
> +	port.iotype = UPIO_MEM;
> +	port.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST;
>  	port.line = 0;
>  
>  	if (early_serial_setup(&port) != 0) {
> diff --git a/arch/ppc/platforms/spruce.c b/arch/ppc/platforms/spruce.c
> --- a/arch/ppc/platforms/spruce.c
> +++ b/arch/ppc/platforms/spruce.c
> @@ -176,8 +176,8 @@ spruce_early_serial_map(void)
>  	memset(&serial_req, 0, sizeof(serial_req));
>  	serial_req.uartclk = uart_clk;
>  	serial_req.irq = UART0_INT;
> -	serial_req.flags = ASYNC_BOOT_AUTOCONF;
> -	serial_req.iotype = SERIAL_IO_MEM;
> +	serial_req.flags = UPF_BOOT_AUTOCONF;
> +	serial_req.iotype = UPIO_MEM;
>  	serial_req.membase = (u_char *)UART0_IO_BASE;
>  	serial_req.regshift = 0;
>  
> diff --git a/drivers/serial/ioc4_serial.c b/drivers/serial/ioc4_serial.c
> --- a/drivers/serial/ioc4_serial.c
> +++ b/drivers/serial/ioc4_serial.c
> @@ -1717,11 +1717,9 @@ ioc4_change_speed(struct uart_port *the_
>  	}
>  
>  	if (cflag & CRTSCTS) {
> -		info->flags |= ASYNC_CTS_FLOW;
>  		port->ip_sscr |= IOC4_SSCR_HFC_EN;
>  	}
>  	else {
> -		info->flags &= ~ASYNC_CTS_FLOW;
>  		port->ip_sscr &= ~IOC4_SSCR_HFC_EN;
>  	}
>  	writel(port->ip_sscr, &port->ip_serial_regs->sscr);
> @@ -1760,18 +1758,6 @@ static inline int ic4_startup_local(stru
>  
>  	info = the_port->info;
>  
> -	if (info->tty) {
> -		set_bit(TTY_IO_ERROR, &info->tty->flags);
> -		clear_bit(TTY_IO_ERROR, &info->tty->flags);
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_HI)
> -			info->tty->alt_speed = 57600;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_VHI)
> -			info->tty->alt_speed = 115200;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_SHI)
> -			info->tty->alt_speed = 230400;
> -		if ((info->flags & ASYNC_SPD_MASK) == ASYNC_SPD_WARP)
> -			info->tty->alt_speed = 460800;
> -	}
>  	local_open(port);
>  
>  	/* set the speed of the serial port */
> diff --git a/drivers/serial/m32r_sio.c b/drivers/serial/m32r_sio.c
> --- a/drivers/serial/m32r_sio.c
> +++ b/drivers/serial/m32r_sio.c
> @@ -80,7 +80,7 @@
>  #include <asm/serial.h>
>  
>  /* Standard COM flags */
> -#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
> +#define STD_COM_FLAGS (UPF_BOOT_AUTOCONF | UPF_SKIP_TEST)
>  
>  /*
>   * SERIAL_PORT_DFNS tells us about built-in ports that have no


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
