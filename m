Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262113AbRE2WBU>; Tue, 29 May 2001 18:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262099AbRE2WBK>; Tue, 29 May 2001 18:01:10 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:33253 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S262088AbRE2WA7>;
	Tue, 29 May 2001 18:00:59 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105292200.PAA29842@csl.Stanford.EDU>
Subject: [CHECKER] 4 security holes in 2.4.4-ac8
To: linux-kernel@vger.kernel.org
Date: Tue, 29 May 2001 15:00:56 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Enclosed are four bugs where 2.4.4-ac8 kernel code appears to directly
read/write user space pointers.  The latter three were found after
forming equivalence classes by:
	(1) recording all routines assigned to the same function pointer
	    field in a structure
	(2) if any member of the equiv class treated a parameter as a
	    user-space pointer, checking that they all do.

Let me know if any of these are wrong.  The first one seems pretty bad.

Dawson
-------------------------------------------------------------------------------
[BUG] raddr seems to be a user pointer, but is written at the end of
      the system call.

ipc/shm.c: ERROR: system call 'sys_shmat' derefs non-tainted param= 3

asmlinkage long sys_shmat (int shmid, char *shmaddr, int shmflg, ulong *raddr)
{
        struct shmid_kernel *shp;


	...
        *raddr = (unsigned long) user_addr;
        err = 0;
        if (IS_ERR(user_addr))
                err = PTR_ERR(user_addr);
        return err;

-----------------------------------------------------------------------------
[BUG] ./drivers/usb/bluetooth.c: dereference of 'buf' at the beginning of
      the switch, and then does a copyin.

	ERROR: equivalence class <struct tty_driver:write> contains 
	2 functions that taint parameter <2>, and 1
	functions that dereference it raw.

	Tainting functions
		[ acm_tty_write:acm.c ]
		[ serial_write:usbserial.c ]
	Dereferencing functions
		[ bluetooth_write:bluetooth.c ]


        switch (*buf) {
                /* First byte indicates the type of packet */
                case CMD_PKT:
                        /* dbg(__FUNCTION__ "- Send cmd_pkt len:%d", count);*/

                        if (in_interrupt()){
                                printk("cmd_pkt from interrupt!\n");
                                return count;
                        }

                        new_buffer = kmalloc (count-1, GFP_KERNEL);

                        if (!new_buffer) {
                                err (__FUNCTION__ "- out of memory.");
                                return -ENOMEM;
                        }

                        if (from_user)
                                copy_from_user (new_buffer, buf+1, count-1);
                        else
                                memcpy (new_buffer, buf+1, count-1);

-------------------------------------------------------
In the equivalence class for file_operations:write: 55 functions treat
their second parameter as tainted, but two functions use it raw.

[BUG]
/* drivers/char/sbc60xxwdt.c: buf is tainted */
static ssize_t fop_write(struct file * file, const char * buf, size_t count, loff_t * ppos)
{       
        /* We can't seek */
        if(ppos != &file->f_pos)
                return -ESPIPE;
        
        /* See if we got the magic character */
        if(count) 
        {
                size_t ofs;
                
                /* note: just in case someone wrote the magic character
                 * five months ago... */
                wdt_expect_close = 0;
                
                /* now scan */
                for(ofs = 0; ofs != count; ofs++)
                        if(buf[ofs] == 'V')
                                wdt_expect_close = 1;
 
                /* Well, anyhow someone wrote to us, we should return that favour */
                next_heartbeat = jiffies + WDT_HEARTBEAT;
        }
        return 0;
}               


[BUG]
/* drivers/usb/mdc800.c: buf is tainted */
static ssize_t mdc800_device_write (struct file *file, const char *buf, size_t len, loff_t *pos)
{               
        int i=0;
 
        spin_lock (&mdc800->io_lock);
        if (mdc800->state != READY)
        {       
                spin_unlock (&mdc800->io_lock);
                return -EBUSY;
        }       
        if (!mdc800->open )
        {       
                spin_unlock (&mdc800->io_lock);
                return -EBUSY;
        }       
 
        while (i<len)
        {       
                if (signal_pending (current))
                { 
                        spin_unlock (&mdc800->io_lock);
                        return -EINTR;
                }
        
                /* check for command start */
                if (buf [i] == (char) 0x55)
                { 
                        mdc800->in_count=0;



Here's the equiv classes:

	Tainting functions
		[ ac_write:applicom.c ]
		[ affs_file_write:file.c ]
		[ block_write:ksyms.c ]
		[ camera_write:dc2xx.c ]
		[ cap_info_write:file_cap.c ]
		[ capi_write:capi.c ]
		[ capinc_raw_write:capi.c ]
		[ coda_file_write:file.c ]
		[ coda_psdev_write:psdev.c ]
		[ cs4281_midi_write:cs4281m.c ]
		[ cs4281_write:cs4281m.c ]
		[ dev_irnet_write:irnet_ppp.h ]
		[ dev_write:raw1394.c ]
		[ ds_write:ds.c ]
		[ dtlk_write:dtlk.c ]
		[ emu10k1_audio_write:audio.c ]
		[ emu10k1_midi_write:midi.c ]
		[ generic_file_write:ksyms.c ]
		[ hdr_write:file_hdr.c ]
		[ hfs_file_write:file.c ]
		[ hpfs_file_write:inode.c ]
		[ i2cdev_write:i2c-dev.c ]
		[ idetape_chrdev_write:ide-tape.c ]
		[ isapnp_info_entry_write:isapnp_proc.c ]
		[ isdn_write:isdn_common.c ]
		[ ixj_enhanced_write:ixj.c ]
		[ lp_write:lp.c ]
		[ mem_write:pcilynx.c ]
		[ microcode_write:microcode.c ]
		[ mtd_write:mtdchar.c ]
		[ mtrr_write:mtrr.c ]
		[ ncp_file_write:file.c ]
		[ nfs_file_write:file.c ]
		[ nvram_write:nvram.c ]
		[ osst_write:osst.c ]
		[ pg_write:pg.c ]
		[ pipe_write:pipe.c ]
		[ ppp_write:ppp_generic.c ]
		[ proc_bus_pci_write:proc.c ]
		[ proc_mpc_write:mpoa_proc.c ]
		[ qic02_tape_write:tpqic02.c ]
		[ sg_write:sg.c ]
		[ shmem_file_write:shmem.c ]
		[ smb_file_write:file.c ]
		[ st_write:st.c ]
		[ tun_chr_write:tun.c ]
		[ usb_audio_write:audio.c ]
		[ vcs_write:vc_screen.c ]
		[ write_kmem:mem.c ]
		[ write_mem:mem.c ]
		[ write_port:mem.c ]
		[ write_profile:proc_misc.c ]
		[ write_rio:rio500.c ]
		[ write_scanner:scanner.c ]
		[ zft_write:zftape-init.c ]
	Dereferencing functions
		[ fop_write:sbc60xxwdt.c ]
		[ mdc800_device_write:mdc800.c ]
