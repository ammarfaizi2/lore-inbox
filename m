Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVB1Aus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVB1Aus (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 19:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVB1Aus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 19:50:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25744 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261522AbVB1AsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 19:48:18 -0500
Message-ID: <42226A3E.6000707@pobox.com>
Date: Sun, 27 Feb 2005 19:47:58 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wen Xiong <wendyx@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
Subject: Re: [ patch 6/7] drivers/serial/jsm: new serial device driver
References: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
In-Reply-To: <42225A64.6070904@us.ltcfwd.linux.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wen Xiong wrote:
> +struct rw_t {
> +	unsigned char	rw_req;		/* Request type			*/
> +	unsigned char	rw_board;	/* Host Adapter board number	*/
> +	unsigned char	rw_conc;	/* Concentrator number		*/
> +	unsigned char	rw_reserved;	/* Reserved for expansion	*/
> +	unsigned int	rw_addr;	/* Address in concentrator	*/
> +	unsigned short	rw_size;	/* Read/write request length	*/
> +	unsigned char	rw_data[128];	/* Data to read/write		*/
> +};

Invalid naming.  Linux kernel style is "struct foo" not "foo_t" nor 
"struct foo_t".

Also, "rw_t" is too short and ambiguous.


> +
> +/***********************************************************************
> + * Shrink Buffer and Board Information definitions and structures.
> +
> + ************************************************************************/
> +			/* Board type return codes */
> +#define	PCXI_TYPE 1	/* Board type at the designated port is a PC/Xi */
> +#define PCXM_TYPE 2	/* Board type at the designated port is a PC/Xm */
> +#define	PCXE_TYPE 3	/* Board type at the designated port is a PC/Xe */
> +#define	MCXI_TYPE 4	/* Board type at the designated port is a MC/Xi */
> +#define COMXI_TYPE 5	/* Board type at the designated port is a COM/Xi */
> +
> +			 /* Non-Zero Result codes. */
> +#define RESULT_NOBDFND 1 /* A Digi product at that port is not config installed */ 
> +#define RESULT_NODESCT 2 /* A memory descriptor was not obtainable */ 
> +#define RESULT_NOOSSIG 3 /* FEP/OS signature was not detected on the board */
> +#define RESULT_TOOSML  4 /* Too small an area to shrink.  */
> +#define RESULT_NOCHAN  5 /* Channel structure for the board was not found */
> +
> +struct shrink_buf_struct {
> +	unsigned int	shrink_buf_vaddr;	/* Virtual address of board */
> +	unsigned int	shrink_buf_phys;	/* Physical address of board */

Major bug.  These should be unsigned long.


> +	unsigned int	shrink_buf_bseg;	/* Amount of board memory */
> +	unsigned int	shrink_buf_hseg;	/* '186 Begining of Dual-Port */
> +
> +	unsigned int	shrink_buf_lseg;	/* '186 Begining of freed memory */ 
> +	unsigned int	shrink_buf_mseg;	/* Linear address from start of
> +						   dual-port were freed memory
> +						   begins, host viewpoint. */
> +
> +	unsigned int	shrink_buf_bdparam;	/* Parameter for xxmemon and
> +						   xxmemoff */
> +
> +	unsigned int	shrink_buf_reserva;	/* Reserved */
> +	unsigned int	shrink_buf_reservb;	/* Reserved */
> +	unsigned int	shrink_buf_reservc;	/* Reserved */
> +	unsigned int	shrink_buf_reservd;	/* Reserved */

why do these exist?


> +	unsigned char	shrink_buf_result;	/* Reason for call failing
> +						   Zero is Good return */
> +	unsigned char	shrink_buf_init;	/* Non-Zero if it caused an
> +						   xxinit call. */
> +
> +	unsigned char	shrink_buf_anports;	/* Number of async ports  */
> +	unsigned char	shrink_buf_snports; 	/* Number of sync  ports */
> +	unsigned char	shrink_buf_type;	/* Board type	1 = PC/Xi,
> +								2 = PC/Xm,
> +								3 = PC/Xe  
> +								4 = MC/Xi  
> +								5 = COMX/i */
> +	unsigned char	shrink_buf_card;	/* Card number */
> +	
> +};
> +
> +/************************************************************************
> + * Structure to get driver status information
> + ************************************************************************/
> +struct digi_dinfo {
> +	unsigned int	dinfo_nboards;		/* # boards configured	*/
> +	char		dinfo_reserved[12];	/* for future expansion */



> +	char		dinfo_version[16];	/* driver version	*/
> +};
> +
> +#define	DIGI_GETDD	('d'<<8) | 248		/* get driver info	*/
> + 
> +/************************************************************************
> + * Structure used with ioctl commands for per-board information
> + *
> + * physsize and memsize differ when board has "windowed" memory
> + ************************************************************************/
> +struct digi_info {
> +	unsigned int	info_bdnum;		/* Board number (0 based)  */
> +	unsigned int	info_ioport;		/* io port address	   */
> +	unsigned int	info_physaddr;		/* memory address	   */
> +	unsigned int	info_physsize;		/* Size of host mem window */
> +	unsigned int	info_memsize;		/* Amount of dual-port mem */
> +						/* on board		   */

Major bugs.  Use unsigned long for addresses.

Use "void __iomem *" for ioremap'd addresses.

> +
> +/*
> + * Driver identification, error and debugging statments
> + *
> + * In theory, you can change all occurances of "digi" in the next
> + * three lines, and the driver printk's will all automagically change.
> + *
> + * APR((fmt, args, ...));	Always prints message
> + * DPR((fmt, args, ...));	Only prints if JSM_TRACER is defined at
> + *				  compile time and jsm_debug!=0
> + *
> + * TRC_TO_CONSOLE:
> + *	Setting this to 1 will turn on some general function tracing
> + *	resulting in a bunch of extra debugging printks to the console
> + *
> + */
> +
> +#define	PROCSTR		"jsm"			/* /proc entries	 */
> +#define	DEVSTR		"/dev/dg/jsm"		/* /dev entries		 */

Never store pathnames in a kernel driver.



> +#define	DRVSTR		"jsm"			/* Driver name string 
> +						 * displayed by APR	 */
> +#define	APR(args)	do {printk(DRVSTR": "); printk args;} while (0)
> +
> +#define TRC_TO_CONSOLE	1
> +
> +/*
> + * Debugging levels can be set using debug insmod variable
> + * They can also be compiled out completely.
> + */
> +
> +#define	DBG_INIT		(jsm_debug & 0x01)
> +#define	DBG_BASIC		(jsm_debug & 0x02)
> +#define	DBG_CORE		(jsm_debug & 0x04)
> +
> +#define	DBG_OPEN		(jsm_debug & 0x08)
> +#define	DBG_CLOSE		(jsm_debug & 0x10)
> +#define	DBG_READ		(jsm_debug & 0x20)
> +#define	DBG_WRITE		(jsm_debug & 0x40)
> +
> +#define	DBG_IOCTL		(jsm_debug & 0x80)
> +
> +#define	DBG_PROC		(jsm_debug & 0x100)
> +#define	DBG_PARAM		(jsm_debug & 0x200)
> +#define	DBG_PSCAN		(jsm_debug & 0x400)
> +#define	DBG_EVENT		(jsm_debug & 0x800)
> +
> +#define	DBG_DRAIN		(jsm_debug & 0x1000)
> +#define	DBG_MSIGS		(jsm_debug & 0x2000)
> +
> +#define	DBG_MGMT		(jsm_debug & 0x4000)
> +#define	DBG_INTR		(jsm_debug & 0x8000)
> +
> +#define	DBG_CARR		(jsm_debug & 0x10000)
> +
> +#if TRC_TO_CONSOLE
> +#define PRINTF_TO_CONSOLE(args) { printk(DRVSTR": "); printk args; }
> +#else //!defined TRACE_TO_CONSOLE
> +#define PRINTF_TO_CONSOLE(args)
> +#endif
> +
> +#define	TRC(args)	{ PRINTF_TO_CONSOLE(args) }
> +
> +#define DPR_INIT(ARGS)		if (DBG_INIT) TRC(ARGS)
> +#define DPR_BASIC(ARGS)		if (DBG_BASIC) TRC(ARGS)
> +#define DPR_CORE(ARGS)		if (DBG_CORE) TRC(ARGS)
> +#define DPR_OPEN(ARGS)		if (DBG_OPEN)  TRC(ARGS)
> +#define DPR_CLOSE(ARGS)		if (DBG_CLOSE)  TRC(ARGS)
> +#define DPR_READ(ARGS)		if (DBG_READ)  TRC(ARGS)
> +#define DPR_WRITE(ARGS)		if (DBG_WRITE) TRC(ARGS)
> +#define DPR_IOCTL(ARGS)		if (DBG_IOCTL) TRC(ARGS)
> +#define DPR_PROC(ARGS)		if (DBG_PROC)  TRC(ARGS)
> +#define DPR_PARAM(ARGS)		if (DBG_PARAM)  TRC(ARGS)
> +#define DPR_PSCAN(ARGS)		if (DBG_PSCAN)  TRC(ARGS)
> +#define DPR_EVENT(ARGS)		if (DBG_EVENT)  TRC(ARGS)
> +#define DPR_DRAIN(ARGS)		if (DBG_DRAIN)  TRC(ARGS)
> +#define DPR_CARR(ARGS)		if (DBG_CARR)  TRC(ARGS)
> +#define DPR_MGMT(ARGS)		if (DBG_MGMT)  TRC(ARGS)
> +#define DPR_INTR(ARGS)		if (DBG_INTR)  TRC(ARGS)
> +#define DPR_MSIGS(ARGS)		if (DBG_MSIGS)  TRC(ARGS)
> +#define DPR(ARGS)		if (jsm_debug) TRC(ARGS)

encapsulate in "do { ... } while (0)"


> +
> +/* Number of boards we support at once. */
> +#define	MAXBOARDS	20
> +#define	MAXPORTS	8
> +#define MAXTTYNAMELEN	200
> +
> +/* Our 3 magic numbers for our board, channel and unit structs */
> +#define JSM_BOARD_MAGIC		0x5c6df104
> +#define JSM_CHANNEL_MAGIC	0x6c6df104
> +#define JSM_UNIT_MAGIC		0x7c6df104
> +
> +/* Serial port types */
> +#define JSM_SERIAL		0
> +
> +#define	SERIAL_TYPE_NORMAL	1
> +
> +#define PORT_NUM(dev)	((dev) & 0x7f)
> +#define IS_PRINT(dev)	(((dev) & 0xff) >= 0x80)
> +
> +/* MAX number of stop characters we will send when our read queue is getting full */
> +#define MAX_STOPS_SENT 5
> +
> +/* 4 extra for alignment play space */
> +#define WRITEBUFLEN		((4096) + 4)
> +#define MYFLIPLEN		N_TTY_BUF_SIZE
> +
> +#define jsm_jiffies_from_ms(a) (((a) * HZ) / 1000)
> +
> +/*
> + * Define a local default termios struct. All ports will be created
> + * with this termios initially.  This is the same structure that is defined
> + * as the default in tty_io.c with the same settings overriden as in serial.c
> + *
> + * In short, this should match the internal serial ports' defaults.
> + */
> +#define	DEFAULT_IFLAGS	(ICRNL | IXON)
> +#define	DEFAULT_OFLAGS	(OPOST | ONLCR)
> +#define	DEFAULT_CFLAGS	(B9600 | CS8 | CREAD | HUPCL | CLOCAL)
> +#define	DEFAULT_LFLAGS	(ISIG | ICANON | ECHO | ECHOE | ECHOK | \
> +			ECHOCTL | ECHOKE | IEXTEN)
> +
> +#ifndef _POSIX_VDISABLE
> +#define   _POSIX_VDISABLE '\0'
> +#endif
> +
> +#define SNIFF_MAX	65536		/* Sniff buffer size (2^n) */
> +#define SNIFF_MASK	(SNIFF_MAX - 1)	/* Sniff wrap mask */
> +
> +/*
> + * All the possible states the driver can be while being loaded.
> + */
> +enum {
> +	DRIVER_INITIALIZED = 0,
> +	DRIVER_READY
> +};
> +
> +/*
> + * All the possible states the board can be while booting up.
> + */
> +enum {
> +	BOARD_FAILED = 0,
> +	BOARD_FOUND,
> +	BOARD_READY
> +};
> +
> +
> +/*************************************************************************
> + *
> + * Structures and closely related defines.
> + *
> + *************************************************************************/
> +
> +struct board_t;
> +struct channel_t;
> +
> +/************************************************************************
> + * Per board operations structure					*
> + ************************************************************************/
> +struct board_ops {
> +	void (*tasklet) (unsigned long data);
> +	JSM_IRQRETURN_TYPE (*intr) (int irq, void *voidbrd, struct pt_regs *regs);
> +	void (*uart_init) (struct channel_t *ch);
> +	void (*uart_off) (struct channel_t *ch);
> +	int  (*drain) (struct tty_struct *tty, uint seconds);
> +	void (*param) (struct channel_t *ch);
> +	void (*assert_modem_signals) (struct channel_t *ch);
> +	void (*flush_uart_write) (struct channel_t *ch);
> +	void (*flush_uart_read) (struct channel_t *ch);
> +	void (*disable_receiver) (struct channel_t *ch);
> +	void (*enable_receiver) (struct channel_t *ch);
> +	void (*send_break) (struct channel_t *ch);
> +	void (*send_start_character) (struct channel_t *ch);
> +	void (*send_stop_character) (struct channel_t *ch);
> +	void (*copy_data_from_queue_to_uart) (struct channel_t *ch);
> +	uint (*get_uart_bytes_left) (struct channel_t *ch);
> +	void (*send_immediate_char) (struct channel_t *ch, unsigned char);
> +};
> +
> +
> +/*
> + *	Per-board information
> + */
> +struct board_t

style:  use "struct board" not "board_t" nor "struct board_t"


> +{
> +	int		magic;		/* Board Magic number.  */
> +	int		boardnum;	/* Board number: 0-32 */
> +
> +	int		type;		/* Type of board */
> +	char		*name;		/* Product Name */
> +	u16		vendor;		/* PCI vendor ID */
> +	u16		device;		/* PCI device ID */
> +	u16		subvendor;	/* PCI subsystem vendor ID */
> +	u16		subdevice;	/* PCI subsystem device ID */

do not store these; they are already in struct pci_dev


> +	uchar		rev;		/* PCI revision ID */
> +	uint		pci_bus;	/* PCI bus value */
> +	uint		pci_slot;	/* PCI slot value */

ditto


> +	struct pci_dev  *pci_dev;
> +	uint		maxports;	/* MAX ports this board can handle */
> +
> +	spinlock_t	bd_lock;	/* Used to protect board */
> +
> +	spinlock_t	bd_intr_lock;	/* Used to protect the poller tasklet and
> +					 * the interrupt routine from each other.
> +					 */
> +
> +	uint		state;		/* State of card. */
> +	wait_queue_head_t state_wait;	/* Place to sleep on for state change */
> +
> +	struct		tasklet_struct helper_tasklet; /* Poll helper tasklet */
> +
> +	uint		nasync;		/* Number of ports on card */
> +
> +	uint		irq;		/* Interrupt request number */
> +	ulong		intr_count;	/* Count of interrupts */
> +
> +	ulong		membase;	/* Start of base memory of the card */
> +	ulong		membase_end;	/* End of base memory of the card */
> +
> +	uchar		*re_map_membase;/* Remapped memory of the card */

mark '__iomem'


> +	ulong		iobase;		/* Start of io base of the card */
> +	ulong		iobase_end;	/* End of io base of the card */
> +
> +	uint		bd_uart_offset;	/* Space between each UART */
> +
> +	struct channel_t *channels[MAXPORTS]; /* array of pointers to our channels. */
> +
> +	struct tty_driver	SerialDriver;
> +	char		SerialName[200];
> +	struct tty_driver	PrintDriver;
> +	char		PrintName[200];
> +
> +	uint		jsm_Major_Serial_Registered;
> +	uint		jsm_Major_TransparentPrint_Registered;
> +
> +	uint		jsm_Serial_Major;
> +	uint		jsm_TransparentPrint_Major;
> +
> +	uint		TtyRefCnt;

style: eliminate StudlyCaps.  use "tty_ref_cnt" not "TtyRefCnt".

This is not C++.


> +	char		*flipbuf;	/* Our flip buffer, alloced if board is found */
> +
> +	u16		dpatype;	/* The board "type", as defined by DPA */
> +	u16		dpastatus;	/* The board "status", as defined by DPA */
> +
> +	uint		bd_dividend;	/* Board/UARTs specific dividend */
> +
> +	struct board_ops *bd_ops;
> +
> +	/* /proc/<board> entries */
> +	struct proc_dir_entry *proc_entry_pointer;
> +	struct jsm_proc_entry *jsm_board_table;
> +};
> +
> +
> +/************************************************************************ 
> + * Unit flag definitions for un_flags.
> + ************************************************************************/
> +#define UN_ISOPEN	0x0001		/* Device is open		*/
> +#define UN_CLOSING	0x0002		/* Line is being closed		*/
> +#define UN_IMM		0x0004		/* Service immediately		*/
> +#define UN_BUSY		0x0008		/* Some work this channel	*/
> +#define UN_BREAKI	0x0010		/* Input break received		*/
> +#define UN_PWAIT	0x0020		/* Printer waiting for terminal	*/
> +#define UN_TIME		0x0040		/* Waiting on time		*/
> +#define UN_EMPTY	0x0080		/* Waiting output queue empty	*/
> +#define UN_LOW		0x0100		/* Waiting output low water mark*/
> +#define UN_EXCL_OPEN	0x0200		/* Open for exclusive use	*/
> +#define UN_WOPEN	0x0400		/* Device waiting for open	*/
> +#define UN_WIOCTL	0x0800		/* Device waiting for open	*/
> +#define UN_HANGUP	0x8000		/* Carrier lost			*/
> +
> +
> +/************************************************************************
> + * Structure for terminal or printer unit. 
> + ************************************************************************/
> +struct un_t {
> +	int	magic;		/* Unit Magic Number.			*/
> +	struct	channel_t *un_ch;
> +	ulong	un_time;
> +	uint	un_type;
> +	uint	un_open_count;	/* Counter of opens to port		*/
> +	struct tty_struct *un_tty;/* Pointer to unit tty structure	*/
> +	uint	un_flags;	/* Unit flags				*/
> +	wait_queue_head_t un_flags_wait; /* Place to sleep to wait on unit */
> +	uint	un_dev;		/* Minor device number			*/
> +};
> +
> +
> +/************************************************************************ 
> + * Device flag definitions for ch_flags.
> + ************************************************************************/
> +#define CH_PRON		0x0001		/* Printer on string		*/
> +#define CH_STOP		0x0002		/* Output is stopped		*/
> +#define CH_STOPI	0x0004		/* Input is stopped		*/
> +#define CH_CD		0x0008		/* Carrier is present		*/
> +#define CH_FCAR		0x0010		/* Carrier forced on		*/
> +#define CH_HANGUP	0x0020		/* Hangup received		*/
> +
> +#define CH_RECEIVER_OFF	0x0040		/* Receiver is off		*/
> +#define CH_OPENING	0x0080		/* Port in fragile open state	*/
> +#define CH_CLOSING	0x0100		/* Port in fragile close state	*/
> +#define CH_FIFO_ENABLED 0x0200		/* Port has FIFOs enabled	*/
> +#define CH_TX_FIFO_EMPTY 0x0400		/* TX Fifo is completely empty	*/
> +#define CH_TX_FIFO_LWM  0x0800		/* TX Fifo is below Low Water	*/
> +#define CH_BREAK_SENDING 0x1000		/* Break is being sent		*/
> +#define CH_LOOPBACK 0x2000		/* Channel is in lookback mode	*/
> +#define CH_FLIPBUF_IN_USE 0x4000	/* Channel's flipbuf is in use	*/
> +#define CH_BAUD0	0x08000		/* Used for checking B0 transitions */
> +
> +/*
> + * Definitions for ch_sniff_flags
> + */
> +#define SNIFF_OPEN	0x1
> +#define SNIFF_WAIT_DATA	0x2
> +#define SNIFF_WAIT_SPACE 0x4
> +
> +
> +/* Our Read/Error/Write queue sizes */
> +#define RQUEUEMASK	0x1FFF		/* 8 K - 1 */
> +#define EQUEUEMASK	0x1FFF		/* 8 K - 1 */
> +#define WQUEUEMASK	0x0FFF		/* 4 K - 1 */
> +#define RQUEUESIZE	(RQUEUEMASK + 1)
> +#define EQUEUESIZE	RQUEUESIZE
> +#define WQUEUESIZE	(WQUEUEMASK + 1)
> +
> +
> +/************************************************************************ 
> + * Channel information structure.
> + ************************************************************************/
> +struct channel_t {
> +	struct uart_port uart_port;
> +	int magic;			/* Channel Magic Number		*/
> +	struct board_t	*ch_bd;		/* Board structure pointer	*/
> +	struct un_t	ch_tun;		/* Terminal unit info		*/
> +	struct un_t	ch_pun;		/* Printer unit info		*/
> +
> +	spinlock_t	ch_lock;	/* provide for serialization */
> +	wait_queue_head_t ch_flags_wait;
> +
> +	uint		ch_portnum;	/* Port number, 0 offset.	*/
> +	uint		ch_open_count;	/* open count			*/
> +	uint		ch_flags;	/* Channel flags		*/
> +
> +	ulong		ch_close_delay;	/* How long we should drop RTS/DTR for */
> +
> +	ulong		ch_cpstime;	/* Time for CPS calculations	*/
> +
> +	tcflag_t	ch_c_iflag;	/* channel iflags		*/
> +	tcflag_t	ch_c_cflag;	/* channel cflags		*/
> +	tcflag_t	ch_c_oflag;	/* channel oflags		*/
> +	tcflag_t	ch_c_lflag;	/* channel lflags		*/
> +	uchar		ch_stopc;	/* Stop character		*/
> +	uchar		ch_startc;	/* Start character		*/
> +
> +	uint		ch_old_baud;	/* Cache of the current baud */
> +	uint		ch_custom_speed;/* Custom baud, if set */
> +
> +	uint		ch_wopen;	/* Waiting for open process cnt */
> +
> +	uchar		ch_mostat;	/* FEP output modem status	*/
> +	uchar		ch_mistat;	/* FEP input modem status	*/
> +
> +	struct neo_uart_struct *ch_neo_uart;	/* Pointer to the "mapped" UART struct */
> +	uchar		ch_cached_lsr;	/* Cached value of the LSR register */
> +
> +	uchar		*ch_rqueue;	/* Our read queue buffer - malloc'ed */
> +	ushort		ch_r_head;	/* Head location of the read queue */
> +	ushort		ch_r_tail;	/* Tail location of the read queue */
> +
> +	uchar		*ch_equeue;	/* Our error queue buffer - malloc'ed */
> +	ushort		ch_e_head;	/* Head location of the error queue */
> +	ushort		ch_e_tail;	/* Tail location of the error queue */
> +
> +	uchar		*ch_wqueue;	/* Our write queue buffer - malloc'ed */
> +	ushort		ch_w_head;	/* Head location of the write queue */
> +	ushort		ch_w_tail;	/* Tail location of the write queue */
> +
> +	ulong		ch_rxcount;	/* total of data received so far */
> +	ulong		ch_txcount;	/* total of data transmitted so far */
> +
> +	uchar		ch_r_tlevel;	/* Receive Trigger level */
> +	uchar		ch_t_tlevel;	/* Transmit Trigger level */
> +
> +	uchar		ch_r_watermark;	/* Receive Watermark */
> +
> +
> +	uint		ch_stops_sent;	/* How many times I have sent a stop character
> +					 * to try to stop the other guy sending.
> +					 */
> +	ulong		ch_err_parity;	/* Count of parity errors on channel */
> +	ulong		ch_err_frame;	/* Count of framing errors on channel */
> +	ulong		ch_err_break;	/* Count of breaks on channel */
> +	ulong		ch_err_overrun; /* Count of overruns on channel */
> +
> +	ulong		ch_xon_sends;	/* Count of xons transmitted */
> +	ulong		ch_xoff_sends;	/* Count of xoffs transmitted */
> +
> +	/* /proc/<board>/<channel> entries */
> +	struct proc_dir_entry *proc_entry_pointer;
> +	struct jsm_proc_entry *jsm_channel_table;
> +
> +	uint ch_sniff_in;
> +	uint ch_sniff_out;
> +	char *ch_sniff_buf;		/* Sniff buffer for proc */
> +	ulong ch_sniff_flags;		/* Channel flags	*/
> +	wait_queue_head_t ch_sniff_wait;
> +};
> +
> +
> +
> +/*************************************************************************
> + *
> + * Prototypes for non-static functions used in more than one module
> + *
> + *************************************************************************/
> +
> +extern void	*jsm_driver_kzmalloc(size_t size, int priority);
> +extern char	*jsm_ioctl_name(int cmd);
> +
> +/*
> + * Our Global Variables.
> + */
> +
> +extern struct uart_driver jsm_uart_driver;
> +
> +extern  int		jsm_driver_state;	/* The state of the driver	*/
> +extern  uint		jsm_Major;		/* Our driver/mgmt major	*/
> +extern  int		jsm_debug;		/* Debug variable		*/
> +extern  int		jsm_rawreadok;		/* Set if user wants rawreads	*/
> +extern  int		jsm_trcbuf_size;	/* Size of the ringbuffer	*/
> +extern  spinlock_t	jsm_global_lock;	/* Driver global spinlock	*/
> +extern  uint		jsm_NumBoards;		/* Total number of boards	*/
> +extern  struct board_t	*jsm_Board[MAXBOARDS];	/* Array of board structs	*/
> +extern  ulong		jsm_poll_counter;	/* Times the poller has run	*/
> +extern  char		*jsm_state_text[];	/* Array of state text		*/
> +extern  char		*jsm_driver_state_text[];/* Array of driver state text */
> +
> +
> +void jsm_proc_register_basic_prescan(void);
> +int jsm_proc_register_basic_postscan(int board_num);
> +void jsm_proc_unregister_all(void);
> +void jsm_proc_unregister_brd(int board_num);
> +
> +#endif
> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_kcompat.h linux-2.6.9.new/drivers/serial/jsm/jsm_kcompat.h
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_kcompat.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_kcompat.h	2005-02-27 17:14:44.747952016 -0600
> @@ -0,0 +1,46 @@
> +/*
> + * Copyright 2004 Digi International (www.digi.com)
> + *      Scott H Kilau <Scott_Kilau at digi dot com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
> + * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
> + * PURPOSE.  See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
> + *
> + *************************************************************************
> + *
> + * This file is intended to contain all the kernel "differences" between the
> + * various kernels that we support.
> + *
> + *************************************************************************/
> +
> +#ifndef __JSM_KCOMPAT_H
> +#define __JSM_KCOMPAT_H
> +
> +# define JSM_MAJOR(x)			(imajor(x))
> +# define JSM_MINOR(x)			(iminor(x))
> +# define JSM_TTY_MAJOR(tty)		(MAJOR(tty_devnum(tty)))
> +# define JSM_TTY_MINOR(tty)		(MINOR(tty_devnum(tty)))
> +
> +# define JSM_MOD_INC_USE_COUNT(rtn)	(rtn = 1)
> +# define JSM_MOD_DEC_USE_COUNT		
> +
> +# define JSM_IRQRETURN_TYPE		irqreturn_t
> +# define JSM_IRQ_RETURN(x)		return x;
> +
> +# define PARM_GEN_IP			(PDE(file->f_dentry->d_inode))
> +
> +# define JSM_GET_TTY_COUNT(x)		(x->count)
> +
> +#endif /* ! __JSM_KCOMPAT_H */
> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_mgmt.h linux-2.6.9.new/drivers/serial/jsm/jsm_mgmt.h
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_mgmt.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_mgmt.h	2005-02-27 17:14:44.747952016 -0600
> @@ -0,0 +1,32 @@
> +/*
> + * Copyright 2003 Digi International (www.digi.com)
> + *	Scott H Kilau <Scott_Kilau at digi dot com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
> + * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
> + * PURPOSE.  See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
> + */
> +
> +#ifndef __JSM_MGMT_H
> +#define __JSM_MGMT_H
> +
> +#define MAXMGMTDEVICES 8
> +
> +int jsm_mgmt_open(struct inode *inode, struct file *file);
> +int jsm_mgmt_close(struct inode *inode, struct file *file);
> +int jsm_mgmt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg);
> +
> +#endif
> +
> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_neo.h linux-2.6.9.new/drivers/serial/jsm/jsm_neo.h
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_neo.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_neo.h	2005-02-27 17:14:44.748951864 -0600
> @@ -0,0 +1,143 @@
> +/*
> + * Copyright 2003 Digi International (www.digi.com)
> + *	Scott H Kilau <Scott_Kilau at digi dot com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
> + * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
> + * PURPOSE.  See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
> + *
> + */
> +
> +#ifndef __JSM_NEO_H
> +#define __JSM_NEO_H
> +
> +#include "jsm_types.h"
> +#include "jsm_driver.h"
> +
> +/************************************************************************ 
> + * Per channel/port NEO UART structure					*
> + ************************************************************************
> + *		Base Structure Entries Usage Meanings to Host		*
> + *									*
> + *	W = read write		R = read only				* 
> + *			U = Unused.					*
> + ************************************************************************/
> +
> +struct neo_uart_struct {
> +	volatile uchar txrx;		/* WR  RHR/THR - Holding Reg */
> +	volatile uchar ier;		/* WR  IER - Interrupt Enable Reg */
> +	volatile uchar isr_fcr;		/* WR  ISR/FCR - Interrupt Status Reg/Fifo Control Reg */
> +	volatile uchar lcr;		/* WR  LCR - Line Control Reg */
> +	volatile uchar mcr;		/* WR  MCR - Modem Control Reg */
> +	volatile uchar lsr;		/* WR  LSR - Line Status Reg */
> +	volatile uchar msr;		/* WR  MSR - Modem Status Reg */
> +	volatile uchar spr;		/* WR  SPR - Scratch Pad Reg */
> +	volatile uchar fctr;		/* WR  FCTR - Feature Control Reg */
> +	volatile uchar efr;		/* WR  EFR - Enhanced Function Reg */
> +	volatile uchar tfifo;		/* WR  TXCNT/TXTRG - Transmit FIFO Reg */	
> +	volatile uchar rfifo;		/* WR  RXCNT/RXTRG - Recieve  FIFO Reg */
> +	volatile uchar xoffchar1;	/* WR  XOFF 1 - XOff Character 1 Reg */
> +	volatile uchar xoffchar2;	/* WR  XOFF 2 - XOff Character 2 Reg */
> +	volatile uchar xonchar1;	/* WR  XON 1 - Xon Character 1 Reg */
> +	volatile uchar xonchar2;	/* WR  XON 2 - XOn Character 2 Reg */
> +
> +	volatile uchar reserved1[0x2ff - 0x200]; /* U   Reserved by Exar */
> +	volatile uchar txrxburst[64];	/* RW  64 bytes of RX/TX FIFO Data */
> +	volatile uchar reserved2[0x37f - 0x340]; /* U   Reserved by Exar */
> +	volatile uchar rxburst_with_errors[64];	/* R  64 bytes of RX FIFO Data + LSR */
> +};

eliminate all use of 'volatile', as mentioned in another message.


> +/* Where to read the extended interrupt register (32bits instead of 8bits) */
> +#define	UART_17158_POLL_ADDR_OFFSET	0x80
> +
> +
> +/*
> + * These are the redefinitions for the FCTR on the XR17C158, since
> + * Exar made them different than their earlier design. (XR16C854)
> + */
> +
> +/* These are only applicable when table D is selected */
> +#define UART_17158_FCTR_RTS_NODELAY	0x00
> +#define UART_17158_FCTR_RTS_4DELAY	0x01
> +#define UART_17158_FCTR_RTS_6DELAY	0x02
> +#define UART_17158_FCTR_RTS_8DELAY	0x03
> +#define UART_17158_FCTR_RTS_12DELAY	0x12
> +#define UART_17158_FCTR_RTS_16DELAY	0x05
> +#define UART_17158_FCTR_RTS_20DELAY	0x13
> +#define UART_17158_FCTR_RTS_24DELAY	0x06
> +#define UART_17158_FCTR_RTS_28DELAY	0x14
> +#define UART_17158_FCTR_RTS_32DELAY	0x07
> +#define UART_17158_FCTR_RTS_36DELAY	0x16
> +#define UART_17158_FCTR_RTS_40DELAY	0x08
> +#define UART_17158_FCTR_RTS_44DELAY	0x09
> +#define UART_17158_FCTR_RTS_48DELAY	0x10
> +#define UART_17158_FCTR_RTS_52DELAY	0x11
> +
> +#define UART_17158_FCTR_RTS_IRDA	0x10
> +#define UART_17158_FCTR_RS485		0x20
> +#define UART_17158_FCTR_TRGA		0x00
> +#define UART_17158_FCTR_TRGB		0x40
> +#define UART_17158_FCTR_TRGC		0x80
> +#define UART_17158_FCTR_TRGD		0xC0
> +
> +/* 17158 trigger table selects.. */
> +#define UART_17158_FCTR_BIT6		0x40
> +#define UART_17158_FCTR_BIT7		0x80
> +
> +/* 17158 TX/RX memmapped buffer offsets */
> +#define UART_17158_RX_FIFOSIZE		64  
> +#define UART_17158_TX_FIFOSIZE		64  
> +
> +/* 17158 Extended IIR's */
> +#define UART_17158_IIR_RDI_TIMEOUT	0x0C	/* Receiver data TIMEOUT */
> +#define UART_17158_IIR_XONXOFF		0x10	/* Received an XON/XOFF char */
> +#define UART_17158_IIR_HWFLOW_STATE_CHANGE 0x20	/* CTS/DSR or RTS/DTR state change */
> +#define UART_17158_IIR_FIFO_ENABLED	0xC0	/* 16550 FIFOs are Enabled */
> +
> +/*
> + * These are the extended interrupts that get sent
> + * back to us from the UART's 32bit interrupt register
> + */
> +#define UART_17158_RX_LINE_STATUS	0x1	/* RX Ready */
> +#define UART_17158_RXRDY_TIMEOUT	0x2	/* RX Ready Timeout */
> +#define UART_17158_TXRDY		0x3	/* TX Ready */
> +#define UART_17158_MSR			0x4	/* Modem State Change */
> +#define UART_17158_TX_AND_FIFO_CLR	0x40	/* Transmitter Holding Reg Empty */
> +#define UART_17158_RX_FIFO_DATA_ERROR	0x80	/* UART detected an RX FIFO Data error */
> +
> +/*
> + * These are the EXTENDED definitions for the 17C158's Interrupt
> + * Enable Register.
> + */
> +#define UART_17158_EFR_ECB	0x10	/* Enhanced control bit */
> +#define UART_17158_EFR_IXON	0x2	/* Receiver compares Xon1/Xoff1 */
> +#define UART_17158_EFR_IXOFF	0x8	/* Transmit Xon1/Xoff1 */
> +#define UART_17158_EFR_RTSDTR	0x40	/* Auto RTS/DTR Flow Control Enable */
> +#define UART_17158_EFR_CTSDSR	0x80	/* Auto CTS/DSR Flow COntrol Enable */
> +
> +#define UART_17158_XOFF_DETECT	0x1	/* Indicates whether chip saw an incoming XOFF char  */
> +#define UART_17158_XON_DETECT	0x2	/* Indicates whether chip saw an incoming XON char */
> +
> +#define UART_17158_IER_RSVD1	0x10	/* Reserved by Exar */
> +#define UART_17158_IER_XOFF	0x20	/* Xoff Interrupt Enable */
> +#define UART_17158_IER_RTSDTR	0x40	/* Output Interrupt Enable */
> +#define UART_17158_IER_CTSDSR	0x80	/* Input Interrupt Enable */
> +
> +/*
> + * Our Global Variables
> + */
> +extern struct board_ops jsm_neo_ops;
> +
> +#endif
> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_pci.h linux-2.6.9.new/drivers/serial/jsm/jsm_pci.h
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_pci.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_pci.h	2005-02-27 17:14:44.748951864 -0600
> @@ -0,0 +1,59 @@
> +/*
> + * Copyright 2003 Digi International (www.digi.com)
> + *	Scott H Kilau <Scott_Kilau at digi dot com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
> + * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
> + * PURPOSE.  See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
> + */
> +
> +/* $Id: jsm_pci.h,v 1.4 2004/01/06 16:44:49 scottk Exp $ */
> +
> +#ifndef __DGAP_PCI_H
> +#define __DGAP_PCI_H
> +
> +#define PCIMAX 32			/* maximum number of PCI boards */
> +
> +#define DIGI_VID				0x114F
> +
> +#define PCI_DEVICE_NEO_4_DID			0x00B0
> +#define PCI_DEVICE_NEO_8_DID			0x00B1
> +#define PCI_DEVICE_NEO_2DB9_DID			0x00C8
> +#define PCI_DEVICE_NEO_2DB9PRI_DID		0x00C9
> +#define PCI_DEVICE_NEO_2RJ45_DID		0x00CA
> +#define PCI_DEVICE_NEO_2RJ45PRI_DID		0x00CB
> +#define PCI_DEVICE_NEO_1_422_DID		0x00CC
> +#define PCI_DEVICE_NEO_1_422_485_DID		0x00CD
> +#define PCI_DEVICE_NEO_2_422_485_DID		0x00CE

belongs in pci_ids.h



> +#define PCI_DEVICE_NEO_4_PCI_NAME		"Neo 4 PCI"
> +#define PCI_DEVICE_NEO_8_PCI_NAME		"Neo 8 PCI"
> +#define PCI_DEVICE_NEO_2DB9_PCI_NAME		"Neo 2 - DB9 Universal PCI"
> +#define PCI_DEVICE_NEO_2DB9PRI_PCI_NAME		"Neo 2 - DB9 Universal PCI - Powered Ring Indicator"
> +#define PCI_DEVICE_NEO_2RJ45_PCI_NAME		"Neo 2 - RJ45 Universal PCI"
> +#define PCI_DEVICE_NEO_2RJ45PRI_PCI_NAME	"Neo 2 - RJ45 Universal PCI - Powered Ring Indicator"
> +#define PCI_DEVICE_NEO_1_422_PCI_NAME		"Neo 1 422 PCI"
> +#define PCI_DEVICE_NEO_1_422_485_PCI_NAME	"Neo 1 422/485 PCI"
> +#define PCI_DEVICE_NEO_2_422_485_PCI_NAME	"Neo 2 422/485 PCI"
> +
> +
> +/* Size of Memory and I/O for PCI (4 K) */
> +#define PCI_RAM_SIZE				0x1000
> +
> +/* Size of Memory (2MB) */
> +#define PCI_MEM_SIZE				0x1000
> +
> +#endif
> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_tty.h linux-2.6.9.new/drivers/serial/jsm/jsm_tty.h
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_tty.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_tty.h	2005-02-27 17:14:44.748951864 -0600
> @@ -0,0 +1,44 @@
> +/*
> + * Copyright 2003 Digi International (www.digi.com)
> + *	Scott H Kilau <Scott_Kilau at digi dot com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
> + * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
> + * PURPOSE.  See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
> + */
> +
> +#ifndef __JSM_TTY_H
> +#define __JSM_TTY_H
> +
> +#include "jsm_driver.h"
> +
> +int	jsm_tty_write(struct uart_port *port);
> +int	jsm_tty_register(struct board_t *brd);
> +
> +int	jsm_tty_init(struct board_t *);
> +int	jsm_uart_port_init(struct board_t *);
> +int	jsm_remove_uart_port(struct board_t *);
> +
> +void	jsm_tty_uninit(struct board_t *);
> +
> +void	jsm_input(struct channel_t *ch);
> +void	jsm_carrier(struct channel_t *ch);
> +void	jsm_check_queue_flow_control(struct channel_t *ch);
> +void	neo_clear_break(struct channel_t *ch, int force);
> +
> +
> +void	jsm_sniff_nowait_nolock(struct channel_t *ch, uchar *text, uchar *buf, int nbuf);
> +
> +#endif
> diff -Nuar linux-2.6.9.orig/drivers/serial/jsm/jsm_types.h linux-2.6.9.new/drivers/serial/jsm/jsm_types.h
> --- linux-2.6.9.orig/drivers/serial/jsm/jsm_types.h	1969-12-31 18:00:00.000000000 -0600
> +++ linux-2.6.9.new/drivers/serial/jsm/jsm_types.h	2005-02-27 17:14:44.749951712 -0600
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright 2003 Digi International (www.digi.com)
> + *	Scott H Kilau <Scott_Kilau at digi dot com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2, or (at your option)
> + * any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY, EXPRESS OR IMPLIED; without even the
> + * implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
> + * PURPOSE.  See the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + *	NOTE: THIS IS A SHARED HEADER. DO NOT CHANGE CODING STYLE!!!
> + */
> +
> +#ifndef __JSM_TYPES_H
> +#define __JSM_TYPES_H
> +
> +#ifndef TRUE
> +# define TRUE 1
> +#endif
> +
> +#ifndef FALSE
> +# define FALSE 0
> +#endif
> +
> +/* Required for our shared headers! */
> +typedef unsigned char uchar;

eliminate this entire file

	Jeff


