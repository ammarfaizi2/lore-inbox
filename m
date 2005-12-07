Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVLGKKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVLGKKT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVLGKKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:10:19 -0500
Received: from mail3.netbeat.de ([193.254.185.27]:9672 "HELO mail3.netbeat.de")
	by vger.kernel.org with SMTP id S1750768AbVLGKKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:10:17 -0500
Subject: Re: Kernel BUG at page_alloc.c:117!
From: Dirk Henning Gerdes <mail@dirk-gerdes.de>
To: zine el abidine Hamid <zine46@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051207094021.87235.qmail@web30611.mail.mud.yahoo.com>
References: <20051207094021.87235.qmail@web30611.mail.mud.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 07 Dec 2005 11:10:24 +0100
Message-Id: <1133950224.5242.3.camel@home.sweethome>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zine!

I didn't get that you have the source-code of the module.
The keyword "tainted" in your lsmod-output shows, that you have a
propritary driver loaded in your system. I thought that would be the
watchdog-driver. But from the sourcecode you can see, that the driver
stands under gpl and won't taint your kernel.
I would strongly suggest to update to 2.4.32 and recompile the
watchdog-module. I don't think, that you will find an error in such old
code in an acceptable time.

Dirk

Am Mittwoch, den 07.12.2005, 10:40 +0100 schrieb zine el abidine Hamid:
> Hello,
> 
> 
> I come back to you. The code of the module wdpiano is
> the next one :
> 
> 
> #include <linux/config.h>
> #include <linux/module.h>
> #include <linux/version.h>
> #include <linux/types.h>
> #include <linux/errno.h>
> #include <linux/kernel.h>
> #include <linux/sched.h>
> #include <linux/miscdevice.h>
> #include <linux/watchdog.h>
> #include <linux/slab.h>
> #include <linux/ioport.h>
> #include <linux/fcntl.h>
> #include <asm/io.h>
> #include <asm/uaccess.h>
> #include <asm/system.h>
> #include <linux/notifier.h>
> #include <linux/reboot.h>
> #include <linux/init.h>
> 
> 
> #define WDIO 0x443
> #define WDIODIS 0x43
> static int wdpiano_is_open=0; // le fichier driver
> n'est pas ouvert
> static unsigned char tempo=10; //temporisation de 10
> second par défaut
> 
> MODULE_PARM(tempo, "b");
> MODULE_PARM_DESC(tempo, "time-out period from 1s to
> 255s (default 10s)");
> MODULE_AUTHOR("Massinissa AGOUDJIL RATP(R)
> <massinissa.agoudjil@ratp.fr>");
> MODULE_LICENSE("GPL");
> 
> static int wdpiano_open(struct inode *inode, struct
> file *file) {
>    if (MINOR(inode->i_rdev)!=WATCHDOG_MINOR) return
> -ENODEV;
>    // access exclusive au fichier de driver
>    if (wdpiano_is_open) return -EBUSY;
>    // Comptage du nombre de chargement
>    MOD_INC_USE_COUNT;
>    //Initialise le timeout
>    outb_p(tempo,WDIO);
>     printk("<1>wdpiano: initialised with a time-out of
> %ds\n",tempo);
>    // limiter l'ouverture 
>    wdpiano_is_open=1;
>    return 0;
> }
> 
> static int wdpiano_release(struct inode *inode, struct
> file *file) {
>    if (MINOR(inode->i_rdev)==WATCHDOG_MINOR) {
> #ifndef CONFIG_WATCHDOG_NOWAYOUT
>       //désactiver le watchdog à la fermeture
>       inb_p(WDIO);
>       inb_p(WDIODIS);
> #endif
>       wdpiano_is_open=0;
>    }
>    MOD_DEC_USE_COUNT;
>    return 0;
> }
> 
> static ssize_t wdpiano_write(struct file *file, const
> char *buf, size_t count, loff_t *ppos) {
>    if (ppos!=&file->f_pos)
>      return -ESPIPE;
>    if (count) {
>       //reinitialiser le timer du watchdog
>       inb_p(WDIODIS);
>       inb_p(WDIO);
>       return 1;
>    }
>    return 0;
> }
> //Un petit message!
> static int wdpiano_notify_sys(struct notifier_block
> *this, unsigned long code,
> 	void *unused) {
> 	if(code==SYS_DOWN || code==SYS_HALT) {
> 	    //désactiver le watchdog à la fermeture
>       	    inb_p(WDIO);
>       	    inb_p(WDIODIS);
> 	}
> 	return NOTIFY_DONE;
> }
> 
> 
> static struct file_operations wdpiano_fops = {
>   owner:          THIS_MODULE,
> // read:           wdpiano_read,
>    write:          wdpiano_write,
>    open:           wdpiano_open,
>    release:        wdpiano_release,
> };
> 
> static struct miscdevice wdpiano_dev = {
>    WATCHDOG_MINOR, //fixer le mineur voir miscdevice.h
> et devices.txt
>      "watchdog",   //fixer le nom de fichier d'accee 
>      &wdpiano_fops
> };
> 
> 
> 
> static struct notifier_block wdpiano_notifier = {
>    wdpiano_notify_sys,
>      NULL,
>      0
> };
> 
> int init_module(void)
> {
>  int retval;
> 
>  printk("Piano watchdog driver RATP(r) V1.0\n");
> 
>  wdpiano_dev.fops = &wdpiano_fops;
>  // Allocation des ressources
>  register_reboot_notifier(&wdpiano_notifier);
>  // Enregistrement du module
>  retval = misc_register(&wdpiano_dev);
> /* if (retval)
>          return retval;*/
>  return 0;
> }
> 
> 
> 
> void cleanup_module(void)
> {
>  printk("<1>wdpiano: cleanup_module\n");
> 
>  // Suppression du module
>  misc_deregister(&wdpiano_dev);
>  //liberation des ressources 
>  unregister_reboot_notifier(&wdpiano_notifier);
> }
> 
> 
> 
> Thank's for your help.
> 
> Zine
> 
> 
> 
> --- Dirk Henning Gerdes <mail@dirk-gerdes.de> a écrit
> :
> 
> > Hi Zine!
> > 
> > That is not the point. But I suppose that the module
> > which runs under
> > 2.4.18 won't run under Linux 2.6. Or quite even
> > under 2.4.32.
> > That could cause some problems, either.
> > If the vendor would give you a new version
> > compatible to 2.6, you could
> > update your whole kernel.
> > 
> > 
> > Am Dienstag, den 06.12.2005, 11:35 +0100 schrieb
> > zine el abidine Hamid:
> > > Why? Do you think that the problem is the module
> > > wdpiano?
> > > 
> > > It's a small program which modify the Watch-Dog
> > Timer
> > > value only...
> > > 
> > > --- Dirk Henning Gerdes <mail@dirk-gerdes.de> a
> > écrit
> > > :
> > > 
> > > > Probably you can contact the manufactor of the
> > board
> > > > to get a driver for
> > > > the watchdog, which runs under newer
> > Linux-versions,
> > > > if you really need
> > > > the watchdog
> > > > Am Montag, den 05.12.2005, 17:48 +0100 schrieb
> > zine
> > > > el abidine Hamid:
> > > > > 
> > > > > I don't know if it's helpfull but the output
> > of
> > > > > ksymoops is :
> > > > > 
> > > > > ksymoops 2.4.4 on i686 2.4.18-3.  Options used
> > > > >      -V (default)
> > > > >      -k /proc/ksyms (default)
> > > > >      -l /proc/modules (default)
> > > > >      -o /lib/modules/2.4.18-3/ (default)
> > > > >      -m /boot/System.map-2.4.18-3 (default)
> > > > > 
> > > > > Warning: You did not tell me where to find
> > symbol
> > > > > information.  I will
> > > > > assume that the log matches the kernel and
> > modules
> > > > > that are running
> > > > > right now and I'll use the default options
> > above
> > > > for
> > > > > symbol resolution.
> > > > > If the current kernel and/or modules do not
> > match
> > > > the
> > > > > log, you can get
> > > > > more accurate output by telling me the kernel
> > > > version
> > > > > and where to find
> > > > > map, modules, ksyms etc.  ksymoops -h explains
> > the
> > > > > options.
> > > > > 
> > > > > Error (expand_objects): cannot
> > stat(/lib/ext3.o)
> > > > for
> > > > > ext3
> > > > > ksymoops: No such file or directory
> > > > > Error (expand_objects): cannot
> > stat(/lib/jbd.o)
> > > > for
> > > > > jbd
> > > > > 
> > > > > ....
> > > > > 
> > > > > 
> > > > > Warning (compare_maps): parport symbol
> > > > > parport_unregister_port not found in
> > > > >
> > > >
> > >
> >
> /lib/modules/2.4.18-3/kernel/drivers/parport/parport.o.
> > > > >  Ignoring
> > > > >
> > > >
> > >
> >
> /lib/modules/2.4.18-3/kernel/drivers/parport/parport.o
> > > > > entry
> > > > > Warning (compare_maps): parport symbol
> > > > > parport_wait_event not found in
> > > > >
> > > >
> > >
> >
> /lib/modules/2.4.18-3/kernel/drivers/parport/parport.o.
> > > > >  Ignoring
> > > > >
> > > >
> > >
> >
> /lib/modules/2.4.18-3/kernel/drivers/parport/parport.o
> > > > > entry
> > > > > Warning (compare_maps): parport symbol
> > > > > parport_wait_peripheral not found in
> > > > >
> > > >
> > >
> >
> /lib/modules/2.4.18-3/kernel/drivers/parport/parport.o.
> > > > >  Ignoring
> > > > >
> > > >
> > >
> >
> /lib/modules/2.4.18-3/kernel/drivers/parport/parport.o
> > > > > entry
> > > > > Warning (compare_maps): parport symbol
> > > > parport_write
> > > > > not found in
> > > > >
> > > >
> > >
> >
> /lib/modules/2.4.18-3/kernel/drivers/parport/parport.o.
> > > > >  Ignoring
> > > > >
> > > >
> > >
> >
> /lib/modules/2.4.18-3/kernel/drivers/parport/parport.o
> > > > > entry
> > > > > Warning (map_ksym_to_module): cannot match
> > loaded
> > > > > module ext3 to a unique module object.  Trace
> > may
> > > > not
> > > > > be reliable.
> > > > > Warning (map_ksym_to_module): cannot match
> > loaded
> > > > > module jbd to a unique module object.  Trace
> > may
> > > > not
> > > > > be reliable.
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:
> > kernel
> > > > BUG at
> > > > > page_alloc.c:117!
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:
> > invalid
> > > > > operand: 0000
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel: CPU: 
> >   0
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel: EIP: 
> >  
> > > > > 0010:[<c01316e7>]    Not tainted
> > > > > 
> > > > > Using defaults from ksymoops -t elf32-i386 -a
> > i386
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:
> > EFLAGS:
> > > > > 00010282
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel: eax:
> > > > 00000020
> > > > >   ebx: c16502d8   ecx: 00000001   edx: 000019
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel: esi:
> > > > 00000000
> > > > >   edi: 000001d0   ebp: 00000000   esp: c1755f
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel: ds:
> > 0018 
> > > > 
> > > > > es: 0018   ss: 0018
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:
> > Process
> > > > > kswapd (pid: 5, stackpage=c1755000)
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:
> > Stack:
> > > > > c02250b5 00000075 c013d0e3 ddf7e600 c16502d8
> > > > 000001d
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:      
> > 
> > > > > c16502f4 c16502d8 c16502d8 000001d0 000001d0
> > > > c012ff8
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:      
> > 
> > > > > 00000125 c02c473c 00000c24 00000848 0000000f
> > > > c013038
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel: Call
> > > > Trace:
> > > > > [<c013d0e3>] try_to_free_buffers [kernel] 0xb3
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:
> > > > [<c013b23a>]
> > > > > try_to_release_page [kernel] 0x3a
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:
> > > > [<c012ff8b>]
> > > > > page_launder_zone [kernel] 0x42b
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:
> > > > [<c0130388>]
> > > > > page_launder [kernel] 0x168
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:
> > > > [<c0130c12>]
> > > > > do_try_to_free_pages [kernel] 0x12
> > > > > Dec  1 14:54:58 Republique_ncl_a kernel:
> > 
> === message truncated ===
> 
> 
> 
> 	
> 
> 	
> 		
> ___________________________________________________________________________ 
> Appel audio GRATUIT partout dans le monde avec le nouveau Yahoo! Messenger 
> Téléchargez cette version sur http://fr.messenger.yahoo.com
> 
-- 
Dirk Henning Gerdes
Bönnersdyk 47
47803 Krefeld

Tel:  02151-755745
      0174-7776640
Mail: mail@dirk-gerdes.de

