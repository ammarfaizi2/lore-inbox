Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131638AbRCSVuS>; Mon, 19 Mar 2001 16:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131641AbRCSVuJ>; Mon, 19 Mar 2001 16:50:09 -0500
Received: from csl.Stanford.EDU ([171.64.66.149]:57023 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S131638AbRCSVt5>;
	Mon, 19 Mar 2001 16:49:57 -0500
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200103192149.NAA29973@csl.Stanford.EDU>
Subject: [CHECKER] question about functions that can fail
To: linux-kernel@vger.kernel.org
Date: Mon, 19 Mar 2001 13:49:01 -0800 (PST)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

right now we are trying to derive which functions can "reasonably" fail
by examining all call sites and recording the number of times functions
are checked vs not checked.  Checking includes comparisions <, >, != 0
directly:
	/* these are all checked uses */
	if(foo())    		if(foo() < 0) 		if(foo() == 0)
		...  			...  			...

As well as through variables:
	res = foo();			res = foo();
	/* result checked */		/* result killed, so not checked */
	if(res < 0)			res = 0;	
		...
	
The analysis is somewhat noisy since we do not recognize all checks
correctly, and sometimes count non-checks as checks.  However, with
that said, the initial results look like there are:
	- 7803 integer functions that return values

	- 7149 consistently always check their result or never check their
	   result.

	- which leaves 654 that have some inconsitencies, where results
	are checked sometimes but not others.  

Both ends of the inconsistent population are interesting:
	- we'd expect that a missing check on an almost-always checked
	function is likely to be a bug

	- we'd expect that a check on a function that is almost never
	checked is possibly the result of a misunderstood interface.
	(e.g., foo() can't fail, but the programmer mistakenly checks
	anyway).

While cases such as request_irq seem like no brainers, I'm not familiar
enough with the kernel to make the judgement call on many of the
others.  I've included the most egregious cases of check/not checked
--- if anyone has time to glance through them and say which they think
are good to check/warn about misunderstood interfaces, we'd appreciate it.

We also have these results for routines that return pointers.  I can
send these too, if there is interest.


Dawson
---------------------------------------------------------------------------

                           Function		: Times Checked	: Not Checked
                             request_irq	:	246	:	13:
                       pci_enable_device	:	118	:	5:
                          usb_submit_urb	:	99	:	6:
                                 filldir	:	89	:	6:
                   serial_paranoia_check	:	57	:	1:
                           skb_queue_len	:	56	:	2:
                        denormal_operand	:	45	:	4:
                               get_tuple	:	44	:	5:
                        i2o_query_scalar	:	38	:	3:
                              permission	:	32	:	1:
                               path_walk	:	32	:	1:
                   devfs_register_chrdev	:	31	:	1:
                               path_init	:	28	:	1:
                        tty_check_change	:	21	:	1:
                          ntfs_read_attr	:	20	:	1:
                               fh_verify	:	19	:	1:
                               WaitReady	:	19	:	1:
                         get_zeroed_page	:	20	:	2:
                           fb_alloc_cmap	:	20	:	2:
                      sock_queue_rcv_skb	:	16	:	1:
                         inode_change_ok	:	15	:	1:
                   idetape_queue_pc_tail	:	15	:	1:
                           parse_options	:	14	:	1:
                             ethdev_init	:	13	:	1:
                  ftape_report_operation	:	11	:	1:
                       fdc_issue_command	:	11	:	1:
                         autofs4_oz_mode	:	11	:	1:
                               hfs_bfind	:	10	:	1:
                          autofs_oz_mode	:	9	:	1:
                                   Sense	:	9	:	1:
-------------------------------------------------------------------------------
                        ide_do_drive_cmd	:	1	:	10:
                         UxCardPortIoInW	:	1	:	10:
               ((*((*dev).ops)).phy_get)	:	1	:	10:
                       clear_epp_timeout	:	2	:	11:
                           send_sig_info	:	1	:	10:
                       unregister_blkdev	:	1	:	11:
                   cramfs_inflate_blocks	:	1	:	12:
                        ibm_send_command	:	2	:	13:
                            t1_get_slice	:	2	:	13:
                          register_qdisc	:	1	:	12:
                 osst_get_frame_position	:	2	:	13:
                        isapnp_read_byte	:	1	:	12:
                                 ReadReg	:	2	:	14:
                  ide_config_drive_speed	:	1	:	13:
                   idetape_read_position	:	1	:	13:
                    read_result_register	:	1	:	13:
                           cc_DriveReset	:	1	:	13:
                       invalidate_inodes	:	3	:	16:
                               read_3393	:	1	:	14:
                            read_sx_byte	:	3	:	17:
                                 do_mmap	:	1	:	15:
                           probe_irq_off	:	2	:	17:
                           arlan_command	:	1	:	17:
                                mtrr_del	:	2	:	18:
                           msp3400c_read	:	2	:	18:
                                   sx_in	:	1	:	17:
                 (((*cs).iif).statcallb)	:	1	:	18:
                 osst_set_frame_position	:	4	:	21:
                           isdnloop_fake	:	4	:	21:
                               skip_atoi	:	1	:	18:
                             read_eeprom	:	3	:	22:
                       nfs_refresh_inode	:	1	:	20:
                   ide_get_best_pio_mode	:	1	:	20:
                             FsmAddTimer	:	1	:	21:
                   idetape_position_tape	:	1	:	21:
                            FPU_to_exp16	:	4	:	24:
                         de_down_pointer	:	1	:	21:
                      i2c_control_device	:	4	:	24:
                             DoC_Command	:	2	:	23:
                 devfs_unregister_chrdev	:	4	:	25:
                                   rc_in	:	1	:	22:
                                reg_read	:	1	:	22:
                                sdla_cmd	:	4	:	25:
                             output_byte	:	2	:	23:
                  create_proc_info_entry	:	2	:	24:
                         zr36060_write_8	:	2	:	25:
                                i365_get	:	1	:	24:
                             fb_set_cmap	:	1	:	25:
                   tty_unregister_driver	:	3	:	27:
                            i2c_sendbyte	:	5	:	30:
                          udf_get_pblock	:	4	:	30:
                                 sendmsg	:	6	:	32:
             register_netdevice_notifier	:	1	:	27:
                     find_first_zero_bit	:	2	:	31:
                                rpc_call	:	4	:	33:
                        zr36060_write_16	:	1	:	30:
                  create_proc_read_entry	:	2	:	33:
                          dev_queue_xmit	:	4	:	35:
                   unregister_filesystem	:	1	:	33:
                     ((*cs).BC_Read_Reg)	:	2	:	37:
          interruptible_sleep_on_timeout	:	7	:	46:
                          request_module	:	2	:	43:
                         proc_net_create	:	7	:	49:
                          pci_map_single	:	1	:	44:
                          del_timer_sync	:	2	:	49:
                        ((*cs).readisac)	:	1	:	55:
                                skb_push	:	1	:	57:
                   pci_write_config_word	:	10	:	67:
                         i2QueueCommands	:	1	:	61:
                               mdio_read	:	14	:	79:
                                FsmEvent	:	10	:	79:
                    pci_read_config_word	:	11	:	93:
                          usb_unlink_urb	:	2	:	89:
                  pci_write_config_dword	:	4	:	112:
                   pci_read_config_dword	:	6	:	124:
                               mod_timer	:	13	:	163:
                        schedule_timeout	:	26	:	238:
                                skb_pull	:	1	:	246:
                    pci_read_config_byte	:	12	:	280:
                               del_timer	:	36	:	444:
