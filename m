Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTEZDPH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 23:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbTEZDPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 23:15:07 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:45727 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263915AbTEZDOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 23:14:53 -0400
Date: Sun, 25 May 2003 22:38:50 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] arch/* strlcpy conversion
Message-ID: <20030526023850.GO2657@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Obvious strlcpy conversions in arch/*. In fact, mips and mips64 had an
actual bug in sys_sysmips(). Confirmed with Keith Wesolowski. I'll send
a seperate patch for 2.4, but the fix for 2.5 is included here.


Index: linux-2.5/arch/arm/kernel/setup.c
===================================================================
--- linux-2.5/arch/arm/kernel/setup.c	(revision 10155)
+++ linux-2.5/arch/arm/kernel/setup.c	(working copy)
@@ -598,8 +598,7 @@
 
 static int __init parse_tag_cmdline(const struct tag *tag)
 {
-	strncpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
-	default_command_line[COMMAND_LINE_SIZE - 1] = '\0';
+	strlcpy(default_command_line, tag->u.cmdline.cmdline, COMMAND_LINE_SIZE);
 	return 0;
 }
 
Index: linux-2.5/arch/arm/common/sa1111-pcipool.c
===================================================================
--- linux-2.5/arch/arm/common/sa1111-pcipool.c	(revision 10155)
+++ linux-2.5/arch/arm/common/sa1111-pcipool.c	(working copy)
@@ -113,8 +113,7 @@
 	if (!(retval = kmalloc (sizeof *retval, SLAB_KERNEL)))
 		return retval;
 
-	strncpy (retval->name, name, sizeof retval->name);
-	retval->name [sizeof retval->name - 1] = 0;
+	strlcpy (retval->name, name, sizeof retval->name);
 
 	retval->dev = pdev;
 	INIT_LIST_HEAD (&retval->page_list);
Index: linux-2.5/arch/um/kernel/umid.c
===================================================================
--- linux-2.5/arch/um/kernel/umid.c	(revision 10155)
+++ linux-2.5/arch/um/kernel/umid.c	(working copy)
@@ -45,8 +45,7 @@
 	if(strlen(name) > UMID_LEN - 1)
 		printk("Unique machine name is being truncated to %s "
 		       "characters\n", UMID_LEN);
-	strncpy(umid, name, UMID_LEN - 1);
-	umid[UMID_LEN - 1] = '\0';
+	strlcpy(umid, name, sizeof(umid));
 
 	umid_is_random = is_random;
 	umid_inited = 1;
@@ -222,7 +221,7 @@
 			       "$HOME\n");
 			exit(1);
 		}
-		strncpy(dir, home, sizeof(dir));
+		strlcpy(dir, home, sizeof(dir));
 		uml_dir++;
 	}
 	len = strlen(dir);
@@ -251,8 +250,7 @@
 	int fd, err;
 	char tmp[strlen(uml_dir) + UMID_LEN + 1];
 
-	strncpy(tmp, uml_dir, sizeof(tmp) - 1);
-	tmp[sizeof(tmp) - 1] = '\0';
+	strlcpy(tmp, uml_dir, sizeof(tmp));
 
 	if(*umid == 0){
 		strcat(tmp, "XXXXXX");
Index: linux-2.5/arch/um/drivers/line.c
===================================================================
--- linux-2.5/arch/um/drivers/line.c	(revision 10155)
+++ linux-2.5/arch/um/drivers/line.c	(working copy)
@@ -563,9 +563,7 @@
 		return(base);
 	}
 
-	strncpy(title, base, len);
-	len -= strlen(title);
-	snprintf(&title[strlen(title)], len, " (%s)", umid);
+	snprintf(title, len, "%s (%s)", base, umid);
 	return(title);
 }
 
Index: linux-2.5/arch/um/os-Linux/drivers/tuntap_user.c
===================================================================
--- linux-2.5/arch/um/os-Linux/drivers/tuntap_user.c	(revision 10155)
+++ linux-2.5/arch/um/os-Linux/drivers/tuntap_user.c	(working copy)
@@ -143,7 +143,7 @@
 		}
 		memset(&ifr, 0, sizeof(ifr));
 		ifr.ifr_flags = IFF_TAP;
-		strncpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name) - 1);
+		strlcpy(ifr.ifr_name, pri->dev_name, sizeof(ifr.ifr_name));
 		if(ioctl(pri->fd, TUNSETIFF, (void *) &ifr) < 0){
 			printk("TUNSETIFF failed, errno = %d", errno);
 			close(pri->fd);
Index: linux-2.5/arch/parisc/kernel/drivers.c
===================================================================
--- linux-2.5/arch/parisc/kernel/drivers.c	(revision 10155)
+++ linux-2.5/arch/parisc/kernel/drivers.c	(working copy)
@@ -398,7 +398,7 @@
 	dev->hpa = hpa;
 	name = parisc_hardware_description(&dev->id);
 	if (name) {
-		strncpy(dev->name, name, sizeof(dev->name)-1);
+		strlcpy(dev->name, name, sizeof(dev->name));
 	}
 
 	return dev;
@@ -601,7 +601,7 @@
 		    ndev = ndev->parent) {
 			snprintf(tmp2, sizeof(tmp2), "%d:%s",
 				 ndev->hw_path, tmp1);
-			strncpy(tmp1, tmp2, sizeof(tmp1));
+			strlcpy(tmp1, tmp2, sizeof(tmp1));
 		}
 	}
 
Index: linux-2.5/arch/mips64/kernel/setup.c
===================================================================
--- linux-2.5/arch/mips64/kernel/setup.c	(revision 10155)
+++ linux-2.5/arch/mips64/kernel/setup.c	(working copy)
@@ -149,9 +149,8 @@
 	bootmem_init ();
 #endif
 
-	strncpy(command_line, arcs_cmdline, CL_SIZE);
-	memcpy(saved_command_line, command_line, CL_SIZE);
-	saved_command_line[CL_SIZE-1] = '\0';
+	strlcpy(command_line, arcs_cmdline, sizeof(command_line));
+	strlcpy(saved_command_line, command_line, sizeof(saved_command_line));
 
 	*cmdline_p = command_line;
 
Index: linux-2.5/arch/mips64/kernel/syscall.c
===================================================================
--- linux-2.5/arch/mips64/kernel/syscall.c	(revision 10155)
+++ linux-2.5/arch/mips64/kernel/syscall.c	(working copy)
@@ -147,14 +147,15 @@
 
 		name = (char *) arg1;
 
-		len = strncpy_from_user(nodename, name, sizeof(nodename));
+		len = strncpy_from_user(nodename, name, __NEW_UTS_LEN);
 		if (len < 0)
 			return -EFAULT;
+		nodename[__NEW_UTS_LEN] = '\0';
 
 		down_write(&uts_sem);
-		strncpy(system_utsname.nodename, name, len);
+		strlcpy(system_utsname.nodename, nodename,
+			sizeof(system_utsname.nodename));
 		up_write(&uts_sem);
-		system_utsname.nodename[len] = '\0';
 		return 0;
 	}
 
Index: linux-2.5/arch/ppc/kernel/setup.c
===================================================================
--- linux-2.5/arch/ppc/kernel/setup.c	(revision 10155)
+++ linux-2.5/arch/ppc/kernel/setup.c	(working copy)
@@ -403,14 +403,14 @@
 	 * are used for initrd_start and initrd_size,
 	 * otherwise they contain 0xdeadbeef.  
 	 */
+	cmd_line[0] = 0;
 	if (r3 >= 0x4000 && r3 < 0x800000 && r4 == 0) {
-		cmd_line[0] = 0;
-		strncpy(cmd_line, (char *)r3 + KERNELBASE,
+		strlcpy(cmd_line, (char *)r3 + KERNELBASE,
 			sizeof(cmd_line));
 	} else if (boot_infos != 0) {
 		/* booted by BootX - check for ramdisk */
 		if (boot_infos->kernelParamsOffset != 0)
-			strncpy(cmd_line, (char *) boot_infos
+			strlcpy(cmd_line, (char *) boot_infos
 				+ boot_infos->kernelParamsOffset,
 				sizeof(cmd_line));
 #ifdef CONFIG_BLK_DEV_INITRD
@@ -439,12 +439,10 @@
 		if (chosen != NULL) {
 			p = get_property(chosen, "bootargs", NULL);
 			if (p && *p) {
-				cmd_line[0] = 0;
-				strncpy(cmd_line, p, sizeof(cmd_line));
+				strlcpy(cmd_line, p, sizeof(cmd_line));
 			}
 		}
 	}
-	cmd_line[sizeof(cmd_line) - 1] = 0;
 #ifdef CONFIG_ADB
 	if (strstr(cmd_line, "adb_sync")) {
 		extern int __adb_probe_sync;
Index: linux-2.5/arch/ppc/platforms/pmac_cpufreq.c
===================================================================
--- linux-2.5/arch/ppc/platforms/pmac_cpufreq.c	(revision 10155)
+++ linux-2.5/arch/ppc/platforms/pmac_cpufreq.c	(working copy)
@@ -330,7 +330,7 @@
 	driver->setpolicy	= &pmac_cpufreq_setpolicy;
 	driver->init		= NULL;
 	driver->exit		= NULL;
-	strncpy(driver->name, "powermac", CPUFREQ_NAME_LEN);
+	strlcpy(driver->name, "powermac", sizeof(driver->name));
 
 	driver->policy[0].cpu				= 0;
 	driver->policy[0].cpuinfo.transition_latency	= CPUFREQ_ETERNAL;
Index: linux-2.5/arch/ppc/platforms/apus_setup.c
===================================================================
--- linux-2.5/arch/ppc/platforms/apus_setup.c	(revision 10155)
+++ linux-2.5/arch/ppc/platforms/apus_setup.c	(working copy)
@@ -130,8 +130,7 @@
 	for( p = cmd_line; p && *p; ) {
 	    i = 0;
 	    if (!strncmp( p, "debug=", 6 )) {
-		    strncpy( debug_device, p+6, sizeof(debug_device)-1 );
-		    debug_device[sizeof(debug_device)-1] = 0;
+		    strlcpy( debug_device, p+6, sizeof(debug_device) );
 		    if ((q = strchr( debug_device, ' ' ))) *q = 0;
 		    i = 1;
 	    } else if (!strncmp( p, "60nsram", 7 )) {
Index: linux-2.5/arch/ppc/platforms/zx4500_setup.c
===================================================================
--- linux-2.5/arch/ppc/platforms/zx4500_setup.c	(revision 10155)
+++ linux-2.5/arch/ppc/platforms/zx4500_setup.c	(working copy)
@@ -104,9 +104,9 @@
 #endif
 
 	/* Get boot string from flash */
-	strncpy(boot_string,
+	strlcpy(boot_string,
 		(char *)ZX4500_BOOT_STRING_ADDR,
-		ZX4500_BOOT_STRING_LEN);
+		sizeof(boot_string));
 	boot_string[ZX4500_BOOT_STRING_LEN] = '\0';
 
 	/* Can be delimited by 0xff */
Index: linux-2.5/arch/ppc/amiga/bootinfo.c
===================================================================
--- linux-2.5/arch/ppc/amiga/bootinfo.c	(revision 10155)
+++ linux-2.5/arch/ppc/amiga/bootinfo.c	(working copy)
@@ -59,8 +59,7 @@
 		break;
 
 	    case BI_COMMAND_LINE:
-		strncpy(cmd_line, (const char *)data, CL_SIZE);
-		cmd_line[CL_SIZE-1] = '\0';
+		strlcpy(cmd_line, (const char *)data, sizeof(cmd_line));
 		break;
 
 	    default:
Index: linux-2.5/arch/ppc/8xx_io/cs4218_tdm.c
===================================================================
--- linux-2.5/arch/ppc/8xx_io/cs4218_tdm.c	(revision 10155)
+++ linux-2.5/arch/ppc/8xx_io/cs4218_tdm.c	(working copy)
@@ -1654,8 +1654,8 @@
 	switch (cmd) {
 		case SOUND_MIXER_INFO: {
 		    mixer_info info;
-		    strncpy(info.id, "CS4218_TDM", sizeof(info.id));
-		    strncpy(info.name, "CS4218_TDM", sizeof(info.name));
+		    strlcpy(info.id, "CS4218_TDM", sizeof(info.id));
+		    strlcpy(info.name, "CS4218_TDM", sizeof(info.name));
 		    info.name[sizeof(info.name)-1] = 0;
 		    info.modify_counter = mixer.modify_counter;
 		    if (copy_to_user((int *)arg, &info, sizeof(info)))
Index: linux-2.5/arch/sparc64/kernel/sys_sunos32.c
===================================================================
--- linux-2.5/arch/sparc64/kernel/sys_sunos32.c	(revision 10155)
+++ linux-2.5/arch/sparc64/kernel/sys_sunos32.c	(working copy)
@@ -704,8 +704,8 @@
 	if(IS_ERR(the_name))
 		return PTR_ERR(the_name);
 
-	strncpy (linux_nfs_mount.hostname, the_name, 254);
-	linux_nfs_mount.hostname [255] = 0;
+	strlcpy(linux_nfs_mount.hostname, the_name,
+		sizeof(linux_nfs_mount.hostname));
 	putname (the_name);
 	
 	return do_mount ("", dir_name, "nfs", linux_flags, &linux_nfs_mount);
Index: linux-2.5/arch/m68k/kernel/setup.c
===================================================================
--- linux-2.5/arch/m68k/kernel/setup.c	(revision 10155)
+++ linux-2.5/arch/m68k/kernel/setup.c	(working copy)
@@ -159,8 +159,7 @@
 		break;
 
 	    case BI_COMMAND_LINE:
-		strncpy(m68k_command_line, (const char *)data, CL_SIZE);
-		m68k_command_line[CL_SIZE-1] = '\0';
+		strlcpy(m68k_command_line, (const char *)data, sizeof(m68k_command_line));
 		break;
 
 	    default:
@@ -255,8 +254,7 @@
 	for( p = *cmdline_p; p && *p; ) {
 	    i = 0;
 	    if (!strncmp( p, "debug=", 6 )) {
-		strncpy( m68k_debug_device, p+6, sizeof(m68k_debug_device)-1 );
-		m68k_debug_device[sizeof(m68k_debug_device)-1] = 0;
+		strlcpy( m68k_debug_device, p+6, sizeof(m68k_debug_device) );
 		if ((q = strchr( m68k_debug_device, ' ' ))) *q = 0;
 		i = 1;
 	    }
Index: linux-2.5/arch/m68k/atari/config.c
===================================================================
--- linux-2.5/arch/m68k/atari/config.c	(revision 10155)
+++ linux-2.5/arch/m68k/atari/config.c	(working copy)
@@ -188,8 +188,7 @@
     char *args = switches;
 
     /* copy string to local array, strsep works destructively... */
-    strncpy( switches, str, len );
-    switches[len] = 0;
+    strlcpy( switches, str, sizeof(switches) );
     atari_switches = 0;
 
     /* parse the options */
Index: linux-2.5/arch/m68k/q40/q40ints.c
===================================================================
--- linux-2.5/arch/m68k/q40/q40ints.c	(revision 10155)
+++ linux-2.5/arch/m68k/q40/q40ints.c	(working copy)
@@ -147,7 +147,7 @@
 	    irq_tab[irq].handler = handler;
 	    irq_tab[irq].flags   = flags;
 	    irq_tab[irq].dev_id  = dev_id;
-	    strncpy(irq_tab[irq].devname,devname,DEVNAME_SIZE);
+	    strlcpy(irq_tab[irq].devname,devname,sizeof(irq_tab[irq].devname));
 	    irq_tab[irq].state = 0;
 	    return 0;
 	  }
Index: linux-2.5/arch/alpha/kernel/setup.c
===================================================================
--- linux-2.5/arch/alpha/kernel/setup.c	(revision 10155)
+++ linux-2.5/arch/alpha/kernel/setup.c	(working copy)
@@ -501,10 +501,9 @@
 	   boot flags depending on the boot mode, we need some shorthand.
 	   This should do for installation.  */
 	if (strcmp(COMMAND_LINE, "INSTALL") == 0) {
-		strcpy(command_line, "root=/dev/fd0 load_ramdisk=1");
+		strlcpy(command_line, "root=/dev/fd0 load_ramdisk=1", sizeof command_line);
 	} else {
-		strncpy(command_line, COMMAND_LINE, sizeof command_line);
-		command_line[sizeof(command_line)-1] = 0;
+		strlcpy(command_line, COMMAND_LINE, sizeof command_line);
 	}
 	strcpy(saved_command_line, command_line);
 	*cmdline_p = command_line;
Index: linux-2.5/arch/i386/kernel/timers/timer.c
===================================================================
--- linux-2.5/arch/i386/kernel/timers/timer.c	(revision 10155)
+++ linux-2.5/arch/i386/kernel/timers/timer.c	(working copy)
@@ -23,10 +23,8 @@
 
 static int __init clock_setup(char* str)
 {
-	if (str) {
-		strncpy(clock_override, str,10);
-		clock_override[9] = '\0';
-	}
+	if (str)
+		strlcpy(clock_override, str, sizeof(clock_override));
 	return 1;
 }
 __setup("clock=", clock_setup);
Index: linux-2.5/arch/ppc64/kernel/setup.c
===================================================================
--- linux-2.5/arch/ppc64/kernel/setup.c	(revision 10155)
+++ linux-2.5/arch/ppc64/kernel/setup.c	(working copy)
@@ -365,16 +365,15 @@
 	cmd_line[0] = 0;
 
 #ifdef CONFIG_CMDLINE
-	strcpy(cmd_line, CONFIG_CMDLINE);
+	strlcpy(cmd_line, CONFIG_CMDLINE, sizeof(cmd_line));
 #endif /* CONFIG_CMDLINE */
 
 	chosen = find_devices("chosen");
 	if (chosen != NULL) {
 		p = get_property(chosen, "bootargs", NULL);
 		if (p != NULL && p[0] != 0)
-			strncpy(cmd_line, p, sizeof(cmd_line));
+			strlcpy(cmd_line, p, sizeof(cmd_line));
 	}
-	cmd_line[sizeof(cmd_line) - 1] = 0;
 
 	/* Look for mem= option on command line */
 	if (strstr(cmd_line, "mem=")) {
Index: linux-2.5/arch/s390/kernel/debug.c
===================================================================
--- linux-2.5/arch/s390/kernel/debug.c	(revision 10155)
+++ linux-2.5/arch/s390/kernel/debug.c	(working copy)
@@ -208,8 +208,7 @@
 	rc->level       = DEBUG_DEFAULT_LEVEL;
 	rc->buf_size    = buf_size;
 	rc->entry_size  = sizeof(debug_entry_t) + buf_size;
-	strncpy(rc->name, name, MIN(strlen(name), (DEBUG_MAX_PROCF_LEN - 1)));
-	rc->name[MIN(strlen(name), (DEBUG_MAX_PROCF_LEN - 1))] = 0;
+	strlcpy(rc->name, name, sizeof(rc->name));
 	memset(rc->views, 0, DEBUG_MAX_VIEWS * sizeof(struct debug_view *));
 #ifdef CONFIG_PROC_FS
 	memset(rc->proc_entries, 0 ,DEBUG_MAX_VIEWS *
Index: linux-2.5/arch/x86_64/kernel/early_printk.c
===================================================================
--- linux-2.5/arch/x86_64/kernel/early_printk.c	(revision 10155)
+++ linux-2.5/arch/x86_64/kernel/early_printk.c	(working copy)
@@ -170,8 +170,7 @@
 	if (early_console_initialized)
 		return -1;
 
-	strncpy(buf,opt,256); 
-	buf[255] = 0; 
+	strlcpy(buf,opt,sizeof(buf)); 
 	space = strchr(buf, ' '); 
 	if (space)
 		*space = 0; 
Index: linux-2.5/arch/x86_64/ia32/ia32_ioctl.c
===================================================================
--- linux-2.5/arch/x86_64/ia32/ia32_ioctl.c	(revision 10155)
+++ linux-2.5/arch/x86_64/ia32/ia32_ioctl.c	(working copy)
@@ -468,8 +468,7 @@
 	if (!dev)
 		return -ENODEV;
 
-	strncpy(ifr32.ifr_name, dev->name, sizeof(ifr32.ifr_name)-1);
-	ifr32.ifr_name[sizeof(ifr32.ifr_name)-1] = 0; 
+	strlcpy(ifr32.ifr_name, dev->name, sizeof(ifr32.ifr_name));
 	dev_put(dev);
 	
 	err = copy_to_user((struct ifreq32 *)arg, &ifr32, sizeof(struct ifreq32));
Index: linux-2.5/arch/cris/kernel/setup.c
===================================================================
--- linux-2.5/arch/cris/kernel/setup.c	(revision 10155)
+++ linux-2.5/arch/cris/kernel/setup.c	(working copy)
@@ -170,14 +170,12 @@
 	*cmdline_p = command_line;
 
 	if (romfs_in_flash) {
-		strncpy(command_line, "root=", COMMAND_LINE_SIZE);
-		strncpy(command_line+5, CONFIG_ETRAX_ROOT_DEVICE,
-			COMMAND_LINE_SIZE-5);
+		strlcpy(command_line, "root=", sizeof(command_line));
+		strlcat(command_line, CONFIG_ETRAX_ROOT_DEVICE,
+			sizeof(command_line));
 
 		/* Save command line copy for /proc/cmdline */
-
-		memcpy(saved_command_line, command_line, COMMAND_LINE_SIZE);
-		saved_command_line[COMMAND_LINE_SIZE-1] = '\0';
+		strlcpy(saved_command_line, command_line, sizeof(saved_command_line));
 	}
 
 	/* give credit for the CRIS port */
Index: linux-2.5/arch/ia64/sn/io/klconflib.c
===================================================================
--- linux-2.5/arch/ia64/sn/io/klconflib.c	(revision 10155)
+++ linux-2.5/arch/ia64/sn/io/klconflib.c	(working copy)
@@ -851,14 +851,12 @@
 		return ;
 
         if  ( (tmp1 = strchr(tmp, ';')) ){
-                strncpy(name, tmp, tmp1-tmp) ;
-                name[tmp1-tmp] = 0 ;
+                strlcpy(name, tmp, tmp1-tmp) ;
         } else {
-                strncpy(name, tmp, (sizeof(name) -1)) ;
-                name[sizeof(name)-1] = 0 ;
+                strlcpy(name, tmp, (sizeof(name))) ;
         }
 
-	strcpy(lb->brd_name, name) ;
+	strlcpy(lb->brd_name, name, sizeof(lb->brd_name)) ;
 }
 
 
Index: linux-2.5/arch/ia64/sn/io/l1_command.c
===================================================================
--- linux-2.5/arch/ia64/sn/io/l1_command.c	(revision 10155)
+++ linux-2.5/arch/ia64/sn/io/l1_command.c	(working copy)
@@ -718,8 +718,7 @@
 
     for( i = 0; i < numlines; i++ )
     {
-	strncpy( line, chr, L1_DISPLAY_LINE_LENGTH );
-	line[L1_DISPLAY_LINE_LENGTH] = '\0';
+	strlcpy( line, chr, sizeof(line) );
 
 	/* generally we want to leave the first line of the L1 display
 	 * alone (so the L1 can manipulate it).  If you need to be able
Index: linux-2.5/arch/ia64/sn/io/sn1/ml_SN_intr.c
===================================================================
--- linux-2.5/arch/ia64/sn/io/sn1/ml_SN_intr.c	(revision 10155)
+++ linux-2.5/arch/ia64/sn/io/sn1/ml_SN_intr.c	(working copy)
@@ -311,14 +311,14 @@
     /* Reserve the level and bump the count. */
     if (rv != -1) {
 	if (reserve) {
-	    int maxlen = sizeof(vecblk->info[bit].ii_name) - 1;
-	    int namelen;
 	    vecblk->info[bit].ii_flags |= (II_RESERVE | resflags);
 	    vecblk->info[bit].ii_owner_dev = owner_dev;
 	    /* Copy in the name. */
-	    namelen = name ? strlen(name) : 0;
-	    strncpy(vecblk->info[bit].ii_name, name, min(namelen, maxlen)); 
-	    vecblk->info[bit].ii_name[maxlen] = '\0';
+	    if (name)
+		strlcpy(vecblk->info[bit].ii_name, name,
+			sizeof(vecblk->info[bit].ii_name));
+	    else
+		vecblk->info[bit].ii_name[0] = '\0';
 	    vecblk->vector_count++;
 	} else {
 	    vecblk->info[bit].ii_flags = 0;	/* Clear all the flags */
@@ -333,7 +333,6 @@
 
 #if defined(DEBUG)
     if (rv >= 0) {
-	    int namelen = name ? strlen(name) : 0;
 	    /* Gather this device - target cpu mapping information
 	     * in a table which can be used later by the idbg "intrmap"
 	     * command
@@ -347,9 +346,10 @@
 		    p->cpuid 	= cpu; 
 		    p->cnodeid 	= cpuid_to_cnodeid(cpu); 
 		    p->bit 	= ip * N_INTPEND_BITS + rv;
-		    strncpy(p->intr_name,
-			    name,
-			    min(MAX_NAME,namelen));
+		    if (name)
+			strlcpy(p->intr_name, name, sizeof(p->intr_name));
+		    else
+			p->intr_name[0] = '\0';
 		    intr_dev_targ_map_size++;
 	    }
 	    mutex_spinunlock(&intr_dev_targ_map_lock,s);
Index: linux-2.5/arch/ia64/sn/io/sn2/klconflib.c
===================================================================
--- linux-2.5/arch/ia64/sn/io/sn2/klconflib.c	(revision 10155)
+++ linux-2.5/arch/ia64/sn/io/sn2/klconflib.c	(working copy)
@@ -787,15 +787,12 @@
         if (tmp == NULL)
 		return ;
 
-        if  ( (tmp1 = strchr(tmp, ';')) ){
-                strncpy(name, tmp, tmp1-tmp) ;
-                name[tmp1-tmp] = 0 ;
-        } else {
-                strncpy(name, tmp, (sizeof(name) -1)) ;
-                name[sizeof(name)-1] = 0 ;
-        }
+        if  ( (tmp1 = strchr(tmp, ';')) )
+                strlcpy(name, tmp, tmp1-tmp);
+        else
+                strlcpy(name, tmp, (sizeof(name)));
 
-	strcpy(lb->brd_name, name) ;
+	strlcpy(lb->brd_name, name, sizeof(lb->brd_name)) ;
 }
 
 
Index: linux-2.5/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c
===================================================================
--- linux-2.5/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	(revision 10155)
+++ linux-2.5/arch/ia64/sn/io/sn2/pcibr/pcibr_slot.c	(working copy)
@@ -149,7 +149,7 @@
     error = pcibr_slot_attach(pcibr_vhdl, slot, D_PCI_HOT_PLUG_ATTACH,
                               l1_msg, &tmp_up_resp.resp_sub_errno);
 
-    strncpy(tmp_up_resp.resp_l1_msg, l1_msg, L1_QSIZE);
+    strlcpy(tmp_up_resp.resp_l1_msg, l1_msg, L1_QSIZE);
     tmp_up_resp.resp_l1_msg[L1_QSIZE] = '\0';
 
     if (COPYOUT(&tmp_up_resp, reqp->req_respp.up, reqp->req_size)) {
@@ -240,8 +240,8 @@
     error = pcibr_slot_detach(pcibr_vhdl, slot, D_PCI_HOT_PLUG_DETACH,
                               l1_msg, &tmp_down_resp.resp_sub_errno);
 
-    strncpy(tmp_down_resp.resp_l1_msg, l1_msg, L1_QSIZE);
-    tmp_down_resp.resp_l1_msg[L1_QSIZE] = '\0';
+    strlcpy(tmp_down_resp.resp_l1_msg, l1_msg,
+	    sizeof(tmp_down_resp.resp_l1_msg));
 
     shutdown_copyout:
 
Index: linux-2.5/arch/ia64/kernel/setup.c
===================================================================
--- linux-2.5/arch/ia64/kernel/setup.c	(revision 10155)
+++ linux-2.5/arch/ia64/kernel/setup.c	(working copy)
@@ -356,8 +356,7 @@
 	unw_init();
 
 	*cmdline_p = __va(ia64_boot_param->command_line);
-	strncpy(saved_command_line, *cmdline_p, sizeof(saved_command_line));
-	saved_command_line[COMMAND_LINE_SIZE-1] = '\0';		/* for safety */
+	strlcpy(saved_command_line, *cmdline_p, sizeof(saved_command_line));
 
 	efi_init();
 
Index: linux-2.5/arch/sparc/kernel/sys_sunos.c
===================================================================
--- linux-2.5/arch/sparc/kernel/sys_sunos.c	(revision 10155)
+++ linux-2.5/arch/sparc/kernel/sys_sunos.c	(working copy)
@@ -738,8 +738,8 @@
 	if(IS_ERR(the_name))
 		return PTR_ERR(the_name);
 
-	strncpy (linux_nfs_mount.hostname, the_name, 254);
-	linux_nfs_mount.hostname [255] = 0;
+	strlcpy(linux_nfs_mount.hostname, the_name,
+		sizeof(linux_nfs_mount.hostname));
 	putname (the_name);
 	
 	return do_mount ("", dir_name, "nfs", linux_flags, &linux_nfs_mount);
Index: linux-2.5/arch/sparc/kernel/ioport.c
===================================================================
--- linux-2.5/arch/sparc/kernel/ioport.c	(revision 10155)
+++ linux-2.5/arch/sparc/kernel/ioport.c	(working copy)
@@ -179,8 +179,7 @@
 		tack += sizeof (struct resource);
 	}
 
-	strncpy(tack, name, XNMLN);
-	tack[XNMLN] = 0;
+	strlcpy(tack, name, XNMLN+1);
 	res->name = tack;
 
 	va = _sparc_ioremap(res, busno, phys, size);
Index: linux-2.5/arch/sparc/prom/bootstr.c
===================================================================
--- linux-2.5/arch/sparc/prom/bootstr.c	(revision 10155)
+++ linux-2.5/arch/sparc/prom/bootstr.c	(working copy)
@@ -52,7 +52,7 @@
 		 * V3 PROM cannot supply as with more than 128 bytes
 		 * of an argument. But a smart bootstrap loader can.
 		 */
-		strncpy(barg_buf, *romvec->pv_v2bootargs.bootargs, BARG_LEN-1);
+		strlcpy(barg_buf, *romvec->pv_v2bootargs.bootargs, sizeof(barg_buf));
 		break;
 	default:
 		break;
Index: linux-2.5/arch/mips/kernel/setup.c
===================================================================
--- linux-2.5/arch/mips/kernel/setup.c	(revision 10155)
+++ linux-2.5/arch/mips/kernel/setup.c	(working copy)
@@ -633,9 +633,8 @@
 		panic("Unsupported architecture");
 	}
 
-	strncpy(command_line, arcs_cmdline, sizeof command_line);
-	command_line[sizeof command_line - 1] = 0;
-	strcpy(saved_command_line, command_line);
+	strlcpy(command_line, arcs_cmdline, sizeof command_line);
+	strlcpy(saved_command_line, command_line, sizeof saved_command_line);
 	*cmdline_p = command_line;
 
 	parse_mem_cmdline();
Index: linux-2.5/arch/mips/kernel/irixelf.c
===================================================================
--- linux-2.5/arch/mips/kernel/irixelf.c	(revision 10155)
+++ linux-2.5/arch/mips/kernel/irixelf.c	(working copy)
@@ -1175,7 +1175,7 @@
 
 		set_fs(KERNEL_DS);
 	}
-	strncpy(psinfo.pr_fname, current->comm, sizeof(psinfo.pr_fname));
+	strlcpy(psinfo.pr_fname, current->comm, sizeof(psinfo.pr_fname));
 
 	notes[2].name = "CORE";
 	notes[2].type = NT_TASKSTRUCT;
Index: linux-2.5/arch/mips/kernel/sysmips.c
===================================================================
--- linux-2.5/arch/mips/kernel/sysmips.c	(revision 10155)
+++ linux-2.5/arch/mips/kernel/sysmips.c	(working copy)
@@ -64,14 +64,15 @@
 
 		name = (char *) arg1;
 
-		len = strncpy_from_user(nodename, name, sizeof(nodename));
+		len = strncpy_from_user(nodename, name, __NEW_UTS_LEN);
 		if (len < 0) 
 			return -EFAULT;
+		nodename[__NEW_UTS_LEN] = '\0';
 
 		down_write(&uts_sem);
-		strncpy(system_utsname.nodename, name, len);
+		strlcpy(system_utsname.nodename, nodename,
+			sizeof(system_utsname.nodename));
 		up_write(&uts_sem);
-		system_utsname.nodename[len] = '\0'; 
 		return 0;
 	}
 
