Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261625AbUK2Ccq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbUK2Ccq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 21:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUK2Ccp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 21:32:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35853 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261622AbUK2C3o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 21:29:44 -0500
Date: Mon, 29 Nov 2004 03:29:43 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove ip2 programs (fwd)
Message-ID: <20041129022943.GR4390@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch forwarded below still applies against 2.6.10-rc2-mm3.

Please apply.



----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 30 Oct 2004 07:49:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-computone@lazuli.wittsend.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove ip2 programs

drivers/char/ip2/ contained three programs. Besides shipping programs at 
this place doesn't sound like a good idea, they didn't even all compile.

The patch below removes them.


diffstat output:
 drivers/char/ip2/Makefile   |   12 -
 drivers/char/ip2/ip2mkdev.c |  123 ---------------
 drivers/char/ip2/ip2stat.c  |  115 --------------
 drivers/char/ip2/ip2trace.c |  279 ------------------------------------
 4 files changed, 529 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/char/ip2/Makefile	2004-10-18 23:55:28.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,12 +0,0 @@
-
-all:	ip2mkdev ip2trace ip2stat
-
-ip2mkdev: ip2mkdev.c
-	cc -o ip2mkdev ip2mkdev.c
-
-ip2trace: ip2trace.c
-	cc -o ip2trace ip2trace.c
-
-ip2stat: ip2stat.c
-	cc -o ip2stat ip2stat.c
-
--- linux-2.6.10-rc1-mm2-full/drivers/char/ip2/ip2mkdev.c	2004-10-18 23:54:29.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,123 +0,0 @@
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <linux/major.h>
-#include <fcntl.h>
-#include <unistd.h>
-#include <stdio.h>
-
-#include "ip2.h"
-#include "i2ellis.h"
-
-char nm[256];
-i2eBordStr Board[2];
-
-static void ex_details(i2eBordStrPtr);
-
-int main (int argc, char *argv[])
-{
-	int board, box, port;
-	int fd;
-	int dev;
-	i2eBordStrPtr pB  = Board;
-
-	// Remove all IP2 devices
-
-	for ( board = 0; board < 4; ++board )
-	{
-		sprintf ( nm, "/dev/ip2ipl%d", board );
-		unlink ( nm );
-		sprintf ( nm, "/dev/ip2stat%d", board );
-		unlink ( nm );
-	}
-
-	for ( port = 0; port < 256; ++port  )
-	{
-		sprintf ( nm, "/dev/ttyF%d", port );
-		unlink ( nm );
-		sprintf ( nm, "/dev/cuf%d", port );
-		unlink ( nm );
-	}
-
-	// Now create management devices, and use the status device to determine how
-	// port devices need to exist, and then create them.
-
-	for ( board = 0; board < 4; ++board )
-	{
-		printf("Board %d: ", board );
-
-		sprintf ( nm, "/dev/ip2ipl%d", board );
-		mknod ( nm, S_IFCHR|0666, (IP2_IPL_MAJOR << 8) | board * 4 );
-		sprintf ( nm, "/dev/ip2stat%d", board );
-		mknod ( nm, S_IFCHR|0666, (IP2_IPL_MAJOR << 8) | board * 4 + 1 );
-
-		fd = open ( nm, O_RDONLY );
-		if ( !fd )
-		{
-			printf ( "Unable to open status device %s\n", nm );
-			exit ( 1 );
-		}
-		if ( ioctl ( fd,  65, Board ) < 0 )
-		{
-			printf ( "not present\n" );
-			close ( fd );
-			unlink ( nm );
-			sprintf ( nm, "/dev/ip2ipl%d", board );
-			unlink ( nm );
-		}
-		else
-		{
-			switch( pB->i2ePom.e.porID & ~POR_ID_RESERVED ) 
-			{
-			case POR_ID_FIIEX: ex_details ( pB );       break;
-			case POR_ID_II_4:  printf ( "ISA-4" );      break;
-			case POR_ID_II_8:  printf ( "ISA-8 std" );  break;
-			case POR_ID_II_8R: printf ( "ISA-8 RJ11" ); break;
-		
-			default:
-				printf ( "Unknown board type, ID = %x", pB->i2ePom.e.porID );
-			}
-
-			for ( box = 0; box < ABS_MAX_BOXES; ++box )
-			{
-				for ( port = 0; port < ABS_BIGGEST_BOX; ++port )
-				{
-					if ( pB->i2eChannelMap[box] & ( 1 << port ) )
-					{
-						dev = port 
-							 + box * ABS_BIGGEST_BOX 
-							 + board * ABS_BIGGEST_BOX * ABS_MAX_BOXES;
-	
-						sprintf ( nm, "/dev/ttyF%d", dev );
-						mknod ( nm, S_IFCHR|0666, (IP2_TTY_MAJOR << 8) | dev );
-						sprintf ( nm, "/dev/cuf%d", dev );
-						mknod ( nm, S_IFCHR|0666, (IP2_CALLOUT_MAJOR << 8) | dev );
-
-						printf(".");
-					}
-				}
-			}
-			printf("\n");
-		}
-	}
-}
-
-static void ex_details ( i2eBordStrPtr pB )
-{
-	int            box;
-	int            i;
-	int            ports = 0;
-	int            boxes = 0;
-
-	for( box = 0; box < ABS_MAX_BOXES; ++box )
-	{
-		if( pB->i2eChannelMap[box] != 0 ) ++boxes;
-		for( i = 0; i < ABS_BIGGEST_BOX; ++i ) 
-		{
-			if( pB->i2eChannelMap[box] & 1<< i ) ++ports;
-		}
-	}
-
-	printf("EX bx=%d pt=%d %d bit", boxes, ports, pB->i2eDataWidth16 ? 16 : 8 );
-}
-
-
--- linux-2.6.10-rc1-mm2-full/drivers/char/ip2/ip2trace.c	2004-10-18 23:54:38.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,279 +0,0 @@
-/*******************************************************************************
-*
-*   (c) 1998 by Computone Corporation
-*
-********************************************************************************
-*
-*
-*   PACKAGE:     Linux tty Device Driver for IntelliPort family of multiport
-*                serial I/O controllers.
-*
-*   DESCRIPTION: Interpretive trace dump utility
-*
-*******************************************************************************/
-
-#include <sys/time.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <ctype.h>
-#include "ip2trace.h"
-
-unsigned long namebuf[100];
-
-struct { 
-	int wrap,
-	size,
-	o_strip,
-	o_stuff,
-	strip,
-	stuff;
-	unsigned long buf[1000];
-} tbuf;
-
-struct sigaction act;
-
-typedef enum { kChar, kInt, kAddr, kHex } eFormat;
-
-int active = 1;
-void quit() { active = 0; }
-
-int main (int argc, char *argv[])
-{
-   int   fd = open ( "/dev/ip2trace", O_RDONLY );
-   int   cnt, i;
-	unsigned long ts, td;
-   struct timeval timeout;
-   union ip2breadcrumb bc;
-	eFormat fmt = kHex;
-
-   if ( fd < 0 )
-   {
-      printf ( "Can't open device /dev/ip2trace\n" );
-      exit ( 1 );
-   }
-
-   act.sa_handler = quit;
-   /*act.sa_mask = 0;*/
-	sigemptyset(&act.sa_mask);
-   act.sa_flags = 0;
-   act.sa_restorer = NULL;
-
-   sigaction ( SIGTERM, &act, NULL );
-
-	ioctl ( fd,  1, namebuf );
-
-	printf ( "iiSendPendingMail %p\n",        namebuf[0] );
-	printf ( "i2InitChannels %p\n",           namebuf[1] );
-	printf ( "i2QueueNeeds %p\n",             namebuf[2] );
-	printf ( "i2QueueCommands %p\n",          namebuf[3] );
-	printf ( "i2GetStatus %p\n",              namebuf[4] );
-	printf ( "i2Input %p\n",                  namebuf[5] );
-	printf ( "i2InputFlush %p\n",             namebuf[6] );
-	printf ( "i2Output %p\n",                 namebuf[7] );
-	printf ( "i2FlushOutput %p\n",            namebuf[8] );
-	printf ( "i2DrainWakeup %p\n",            namebuf[9] );
-	printf ( "i2DrainOutput %p\n",            namebuf[10] );
-	printf ( "i2OutputFree %p\n",             namebuf[11] );
-	printf ( "i2StripFifo %p\n",              namebuf[12] );
-	printf ( "i2StuffFifoBypass %p\n",        namebuf[13] );
-	printf ( "i2StuffFifoFlow %p\n",          namebuf[14] );
-	printf ( "i2StuffFifoInline %p\n",        namebuf[15] );
-	printf ( "i2ServiceBoard %p\n",           namebuf[16] );
-	printf ( "serviceOutgoingFifo %p\n",      namebuf[17] );
-	printf ( "ip2_init %p\n",                 namebuf[18] ); 
-	printf ( "ip2_init_board %p\n",           namebuf[19] ); 
-	printf ( "find_eisa_board %p\n",          namebuf[20] );  
-	printf ( "set_irq %p\n",                  namebuf[21] );  
-	printf ( "ex_details %p\n",               namebuf[22] );  
-	printf ( "ip2_interrupt %p\n",            namebuf[23] );  
-	printf ( "ip2_poll %p\n",                 namebuf[24] );  
-	printf ( "service_all_boards %p\n",        namebuf[25] );  
-	printf ( "do_input %p\n",                 namebuf[27] );  
-	printf ( "do_status %p\n",                namebuf[26] );  
-	printf ( "open_sanity_check %p\n",        namebuf[27] );  
-	printf ( "open_block_til_ready %p\n",     namebuf[28] );   
-	printf ( "ip2_open %p\n",                 namebuf[29] );  
-	printf ( "ip2_close %p\n",                namebuf[30] );  
-	printf ( "ip2_hangup %p\n",               namebuf[31] );  
-	printf ( "ip2_write %p\n",                namebuf[32] );  
-	printf ( "ip2_putchar %p\n",              namebuf[33] );  
-	printf ( "ip2_flush_chars %p\n",          namebuf[34] );  
-	printf ( "ip2_write_room %p\n",           namebuf[35] );  
-	printf ( "ip2_chars_in_buf %p\n",         namebuf[36] );  
-	printf ( "ip2_flush_buffer %p\n",         namebuf[37] );  
-	//printf ( "ip2_wait_until_sent %p\n",      namebuf[38] );  
-	printf ( "ip2_throttle %p\n",             namebuf[39] );  
-	printf ( "ip2_unthrottle %p\n",           namebuf[40] );  
-	printf ( "ip2_ioctl %p\n",                namebuf[41] );  
-	printf ( "get_modem_info %p\n",           namebuf[42] );  
-	printf ( "set_modem_info %p\n",           namebuf[43] );  
-	printf ( "get_serial_info %p\n",          namebuf[44] );  
-	printf ( "set_serial_info %p\n",          namebuf[45] );  
-	printf ( "ip2_set_termios %p\n",          namebuf[46] );  
-	printf ( "ip2_set_line_discipline %p\n",  namebuf[47] );  
-	printf ( "set_line_characteristics %p\n", namebuf[48] );  
-
-	printf("\n-------------------------\n");
-	printf("Start of trace\n");
-
-   while ( active ) {
-      cnt = read ( fd, &tbuf, sizeof tbuf );
-
-      if ( cnt ) {
-         if ( tbuf.wrap ) {
-            printf ( "\nTrace buffer: wrap=%d, strip=%d, stuff=%d\n",
-                     tbuf.wrap, tbuf.strip, tbuf.stuff );
-         }
-         for ( i = 0, bc.value = 0; i < cnt; ++i ) {
-				if ( !bc.hdr.codes ) {
-					td = tbuf.buf[i] - ts;
-					ts = tbuf.buf[i++];
-					bc.value = tbuf.buf[i];
-	
-					printf ( "\n(%d) Port %3d ", ts, bc.hdr.port );
-
-					fmt = kHex;
-
-					switch ( bc.hdr.cat )
-					{
-					case ITRC_INIT:
-						printf ( "Init       %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_OPEN:
-						printf ( "Open       %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_CLOSE:
-						printf ( "Close      %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_DRAIN:
-						printf ( "Drain      %d: ", bc.hdr.label );
-						fmt = kInt;
-						break;
-
-					case ITRC_IOCTL:
-						printf ( "Ioctl      %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_FLUSH:
-						printf ( "Flush      %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_STATUS:
-						printf ( "GetS       %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_HANGUP:
-						printf ( "Hangup     %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_INTR:
-						printf ( "*Intr      %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_SFLOW:
-						printf ( "SFlow      %d: ", bc.hdr.label );
-						fmt = kInt;
-						break;
-
-					case ITRC_SBCMD:
-						printf ( "Bypass CMD %d: ", bc.hdr.label );
-						fmt = kInt;
-						break;
-
-					case ITRC_SICMD:
-						printf ( "Inline CMD %d: ", bc.hdr.label );
-						fmt = kInt;
-						break;
-
-					case ITRC_MODEM:
-						printf ( "Modem      %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_INPUT:
-						printf ( "Input      %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_OUTPUT:
-						printf ( "Output     %d: ", bc.hdr.label );
-						fmt = kInt;
-						break;
-
-					case ITRC_PUTC:
-						printf ( "Put char   %d: ", bc.hdr.label );
-						fmt = kChar;
-						break;
-
-					case ITRC_QUEUE:
-						printf ( "Queue CMD  %d: ", bc.hdr.label );
-						fmt = kInt;
-						break;
-
-					case ITRC_STFLW:
-						printf ( "Stat Flow  %d: ", bc.hdr.label );
-						fmt = kInt;
-						break;
-
-					case ITRC_SFIFO:
-						printf ( "SFifo      %d: ", bc.hdr.label );
-						break;
-
-					case ITRC_VERIFY:
-						printf ( "Verfy      %d: ", bc.hdr.label );
-						fmt = kHex;
-						break;
-
-					case ITRC_WRITE:
-						printf ( "Write      %d: ", bc.hdr.label );
-						fmt = kChar;
-						break;
-
-					case ITRC_ERROR:
-						printf ( "ERROR      %d: ", bc.hdr.label );
-						fmt = kInt;
-						break;
-
-					default:
-						printf ( "%08x          ", tbuf.buf[i] );
-						break;
-					}
-				}
-				else 
-				{
-               --bc.hdr.codes;
-					switch ( fmt )
-					{
-					case kChar:
-						printf ( "%c (0x%02x) ", 
-							isprint ( tbuf.buf[i] ) ? tbuf.buf[i] : '.', tbuf.buf[i] );
-						break;
-					case kInt:
-						printf ( "%d ", tbuf.buf[i] );
-						break;
-
-					case kAddr:
-					case kHex:
-						printf ( "0x%x ", tbuf.buf[i] );
-						break;
-					}
-				}
-         }
-      }
-      fflush ( stdout );
-      timeout.tv_sec = 0;
-      timeout.tv_usec = 250;
-      select ( 0, NULL, NULL, NULL, &timeout );
-
-   }
-	printf("\n-------------------------\n");
-	printf("End of trace\n");
-
-   close ( fd );
-}
-
--- linux-2.6.10-rc1-mm2-full/drivers/char/ip2/ip2stat.c	2004-10-18 23:53:51.000000000 +0200
+++ /dev/null	2004-08-23 02:01:39.000000000 +0200
@@ -1,115 +0,0 @@
-/*******************************************************************************
-*
-*   (c) 1998 by Computone Corporation
-*
-********************************************************************************
-*
-*
-*   PACKAGE:     Linux tty Device Driver for IntelliPort family of multiport
-*                serial I/O controllers.
-*
-*   DESCRIPTION: Status display utility
-*
-*******************************************************************************/
-
-#include <sys/time.h>
-#include <sys/types.h>
-#include <unistd.h>
-#include <stdio.h>
-#include <signal.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <ctype.h>
-#include <linux/timer.h>
-#include <linux/termios.h>
-
-#include "i2ellis.h"
-#include "i2lib.h"
-
-i2eBordStr Board[2];
-i2ChanStr  Port[2];
-
-struct driver_stats
-{
-	ULONG ref_count;
-	ULONG irq_counter;
-	ULONG bh_counter;
-} Driver;
-
-char	devname[20];
-
-int main (int argc, char *argv[])
-{
-   int   fd;
-   int   dev, i;
-	i2eBordStrPtr pB  = Board;
-	i2ChanStrPtr  pCh = Port;
-
-	if ( argc != 2 ) 
-	{
-		printf ( "Usage: %s <port>\n", argv[0] );
-		exit(1);
-	}
-	i = sscanf ( argv[1], "/dev/ttyF%d", &dev );
-
-	if ( i != 1 ) exit(1);
-
-	//printf("%s: board %d, port %d\n", argv[1], dev / 64, dev % 64 );
-
-	sprintf ( devname, "/dev/ip2stat%d", dev / 64 );
-	if( 0 > ( fd = open ( devname, O_RDONLY ) ) ) {
-		// Conventional name failed - try devfs name
-		sprintf ( devname, "/dev/ip2/stat%d", dev / 64 );
-		if( 0 > ( fd = open ( devname, O_RDONLY ) ) ) {
-			// Where is our board???
-			printf( "Unable to open board %d to retrieve stats\n",
-				dev / 64 );
-			exit( 255 );
-		}
-	}
-
-	ioctl ( fd,  64, &Driver );
-	ioctl ( fd,  65, Board );
-	ioctl ( fd,  dev % 64, Port );
-
-	printf ( "Driver statistics:-\n" );
-	printf ( " Reference Count:  %d\n", Driver.ref_count );
-	printf ( " Interrupts to date:   %ld\n", Driver.irq_counter );
-	printf ( " Bottom half to date:  %ld\n", Driver.bh_counter );
-
-	printf ( "Board statistics(%d):-\n",dev/64 );
-	printf ( "FIFO: remains = %d%s\n", pB->i2eFifoRemains, 
-				pB->i2eWaitingForEmptyFifo ? ", busy" : "" );
-	printf ( "Mail: out mail = %02x\n", pB->i2eOutMailWaiting ); 
-	printf ( "  Input interrupts : %d\n", pB->i2eFifoInInts );
-	printf ( "  Output interrupts: %d\n", pB->i2eFifoOutInts );
-	printf ( "  Flow queued      : %ld\n", pB->debugFlowQueued );
-	printf ( "  Bypass queued    : %ld\n", pB->debugBypassQueued );
-	printf ( "  Inline queued    : %ld\n", pB->debugInlineQueued );
-	printf ( "  Data queued      : %ld\n", pB->debugDataQueued );
-	printf ( "  Flow packets     : %ld\n", pB->debugFlowCount );
-	printf ( "  Bypass packets   : %ld\n", pB->debugBypassCount );
-	printf ( "  Inline packets   : %ld\n", pB->debugInlineCount );
-	printf ( "  Mail status      : %x\n",  pB->i2eStatus );
-	printf ( "  Output mail      : %x\n",  pB->i2eOutMailWaiting );
-	printf ( "  Fatal flag       : %d\n",  pB->i2eFatal );
-
-	printf ( "Channel statistics(%s:%d):-\n",argv[1],dev%64 );
-	printf ( "ibuf: stuff = %d strip = %d\n", pCh->Ibuf_stuff, pCh->Ibuf_strip );
-	printf ( "obuf: stuff = %d strip = %d\n", pCh->Obuf_stuff, pCh->Obuf_strip );
-	printf ( "pbuf: stuff = %d\n", pCh->Pbuf_stuff );
-	printf ( "cbuf: stuff = %d strip = %d\n", pCh->Cbuf_stuff, pCh->Cbuf_strip );
-	printf ( "infl: count = %d room = %d\n", pCh->infl.asof, pCh->infl.room );
-	printf ( "outfl: count = %d room = %d\n", pCh->outfl.asof, pCh->outfl.room );
-	printf ( "throttled = %d ",pCh->throttled);
-	printf ( "bookmarks = %d ",pCh->bookMarks);
-	printf ( "flush_flags = %x\n",pCh->flush_flags);
-	printf ( "needs: ");
-	if (pCh->channelNeeds & NEED_FLOW)   printf("FLOW ");
-	if (pCh->channelNeeds & NEED_INLINE) printf("INLINE ");
-	if (pCh->channelNeeds & NEED_BYPASS) printf("BYPASS ");
-	if (pCh->channelNeeds & NEED_CREDIT) printf("CREDIT ");
-	printf ( "\n");
-	printf ( "dss: in = %x, out = %x\n",pCh->dataSetIn,pCh->dataSetOut);
-	
-}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

