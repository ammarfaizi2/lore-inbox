Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSKKWan>; Mon, 11 Nov 2002 17:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSKKWan>; Mon, 11 Nov 2002 17:30:43 -0500
Received: from smtp1.Stanford.EDU ([171.64.14.23]:6615 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S261486AbSKKWah>; Mon, 11 Nov 2002 17:30:37 -0500
Message-Id: <5.1.0.14.2.20021111143426.045c4d90@rdg12.pobox.stanford.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 11 Nov 2002 14:35:06 -0800
To: linux-kernel@vger.kernel.org
From: Russell Greene <rdg12@stanford.edu>
Subject: [CHECKER] 18 potential security holes
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

      Here are 18 probable security holes from 2.4.19 where user input 
(e.g. data from
copy_from_user, get_user, etc) is used by a trusting function.  This can 
happen
when tainted data is:

1. passed as a length argument to copy_*user (or passed to a
function that does), or
2. is used as an array index, or
3. an untrusted buffer is passed to strlen or strchr (since these functions 
search the buffer until
      a null terminator is found and thus might overrun a nonterminated 
buffer).

You can look at this checker as essentially tracking whether the
information from an untrusted source (e.g., from copy_from_user) can reach
a trusting sink (e.g., an array index).

Here is a summary of the bugs found:

#  Total          = 18
# BUGs  |       File Name
8       |       /drivers/applicom.c
2       |       /drivers/ide-taskfile.c
2       |       /isdn/ioctl.c
1       |       /drivers/console.c
1       |       /message/i2o_config.c
1       |       /message/mptctl.c
1       |       /drivers/dv1394.c
1       |       /drivers/ixj.c
1       |       /linux-2.4.19/module.c


---------------------------------------------------------
[BUG] random sigalarm killed.
/u1/rdg12/kernel/linux-2.4.19/drivers/telephony/ixj.c:5972:ixj_build_cadence: 
ERROR:USER:5972:5972:direct deref of tainted pointer (*(*j).cadence_t).ce
         lcp->ce = (void *) lcep;
         j->cadence_t = lcp;
         j->tone_cadence_state = 0;
         ixj_set_tone_on(lcp->ce[0].tone_on_time, j);
         ixj_set_tone_off(lcp->ce[0].tone_off_time, j);

Error --->
         if (j->cadence_t->ce[j->tone_cadence_state].freq0) {
                 ti.tone_index = j->cadence_t->ce[j->tone_cadence_state].index;
                 ti.freq0 = j->cadence_t->ce[j->tone_cadence_state].freq0;
                 ti.gain0 = j->cadence_t->ce[j->tone_cadence_state].gain0;
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/ieee1394/dv1394.c:2157:dv1394_procfs_write: 
ERROR:USER:2154:2157:passing unsafe_source data new_value to strchr
         if (count > 64)
                 len = 64;
         else
                 len = count;

Start --->
         if (copy_from_user( new_value, buffer, len))
                 return -EFAULT;

Error --->
         pos = strchr(new_value, '=');
         if (pos != NULL) {
                 int val_len = len - (pos-new_value) - 1;
                 char buf[64];
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/isdn/sc/ioctl.c:264:sc_ioctl: 
ERROR:USER:257:264:passing unsafe_source data dn to strlen
                 pr_debug("%s: SCIOSETDN: ioctl received\n", 
adapter[card]->devicename);

                 /*
                 * Get the spid from user space
                 */
Start --->
                 if ((err = copy_from_user(dn, (char *) data->dataptr, 
sizeof(dn))))
                         return err;

                 pr_debug("%s: SCIOCSETDN: setting channel %d dn to %s\n",
                         adapter[card]->devicename, data->channel, dn);
                 status = send_and_receive(card, CEPID, ceReqTypeCall,
                         ceReqClass0, ceReqCallSetMyNumber, data->channel,
Error --->
                         strlen(dn),dn,&rcvmsg, SAR_TIMEOUT);
                 if(!status && !rcvmsg.rsp_status) {
                         pr_debug("%s: SCIOCSETDN: command successful\n",
                                 adapter[card]->devicename);
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/isdn/sc/ioctl.c:200:sc_ioctl: 
ERROR:USER:193:200:passing unsafe_source data spid to strlen
                 pr_debug("%s: DCBIOSETSPID: ioctl received\n", 
adapter[card]->devicename);

                 /*
                 * Get the spid from user space
                 */
Start --->
                 if ((err = copy_from_user(spid, (char *) data->dataptr, 
sizeof(spid))))
                         return err;

                 pr_debug("%s: SCIOCSETSPID: setting channel %d spid to %s\n",
                         adapter[card]->devicename, data->channel, spid);
                 status = send_and_receive(card, CEPID, ceReqTypeCall,
                         ceReqClass0, ceReqCallSetSPID, data->channel,
Error --->
                         strlen(spid), spid, &rcvmsg, SAR_TIMEOUT);
                 if(!status && !rcvmsg.rsp_status) {
                         pr_debug("%s: SCIOCSETSPID: command successful\n",
                                 adapter[card]->devicename);
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/char/applicom.c:728:ac_ioctl: 
ERROR:USER:712:728:index of apbs using needub IndexCard
         if (copy_from_user(adgl, (void *)arg,sizeof(struct st_ram_io))) {
                 kfree(adgl);
                 return -EFAULT;
         }

Start --->
         IndexCard = adgl->num_card-1;

         ... DELETED 10 lines ...

         }

         switch (cmd) {

         case 0:
Error --->
                 pmem = apbs[IndexCard].RamIO;
                 for (i = 0; i < sizeof(struct st_ram_io); i++)
                         ((unsigned char *)adgl)[i]=readb(pmem++);
                 if (copy_to_user((void *)arg, adgl, sizeof(struct st_ram_io)))
---------------------------------------------------------
[BUG] target is not range checked -- used as index
/u1/rdg12/kernel/linux-2.4.19/drivers/message/fusion/mptctl.c:1812:mptctl_do_mpt_command: 
ERROR:USER:1792:1812:index of (*hd).Targets using tainted target
                         SCSIIORequest_t *pScsiReq = (SCSIIORequest_t *) mf;
                         VirtDevice      *pTarget = NULL;
                         MPT_SCSI_HOST   *hd = NULL;
                         int qtag = MPI_SCSIIO_CONTROL_UNTAGGED;
                         int scsidir = 0;
Start --->
                         int target = (int) pScsiReq->TargetID;

         ... DELETED 14 lines ...

                                 cpu_to_le32(ioc->sense_buf_low_dma
                                    + (req_idx * MPT_SENSE_BUFFER_ALLOC));

                         if ( (hd = (MPT_SCSI_HOST *) ioc->sh->hostdata)) {
                                 if (hd->Targets)
Error --->
                                         pTarget = hd->Targets[target];
                         }

                         if (pTarget &&(pTarget->tflags & 
MPT_TARGET_FLAGS_Q_YES))
---------------------------------------------------------
[BUG]  IndexCard indexing into apbs array w/o always being checked
/u1/rdg12/kernel/linux-2.4.19/drivers/char/applicom.c:735:ac_ioctl: 
ERROR:USER:712:735:index of apbs using needub IndexCard
         if (copy_from_user(adgl, (void *)arg,sizeof(struct st_ram_io))) {
                 kfree(adgl);
                 return -EFAULT;
         }

Start --->
         IndexCard = adgl->num_card-1;

         ... DELETED 17 lines ...

                         ((unsigned char *)adgl)[i]=readb(pmem++);
                 if (copy_to_user((void *)arg, adgl, sizeof(struct st_ram_io)))
                         ret = -EFAULT;
                 break;
         case 1:
Error --->
                 pmem = apbs[IndexCard].RamIO + CONF_END_TEST;
                 for (i = 0; i < 4; i++)
                         adgl->conf_end_test[i] = readb(pmem++);
                 for (i = 0; i < 2; i++)
---------------------------------------------------------
[BUG] seems like a bug .. c is not checked and indexes array
/u1/rdg12/kernel/linux-2.4.19/drivers/char/console.c:1938:do_con_write: 
ERROR:USER:1898:1938:index of (*(vc_cons[currcons]).d).vc_translate using 
tainted c
         /* undraw cursor first */
         if (IS_FG)
                 hide_cursor(currcons);

         while (!tty->stopped && count) {
Start --->
                 c = *buf;

         ... DELETED 34 lines ...

                     } else {
                       tc = c;
                       utf_count = 0;
                     }
                 } else {        /* no utf */
Error --->
                   tc = translate[toggle_meta ? (c|0x80) : c];
                 }

                 /* If the original code was a control character we
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/char/applicom.c:756:ac_ioctl: 
ERROR:USER:712:756:index of apbs using needub IndexCard
         if (copy_from_user(adgl, (void *)arg,sizeof(struct st_ram_io))) {
                 kfree(adgl);
                 return -EFAULT;
         }

Start --->
         IndexCard = adgl->num_card-1;

         ... DELETED 38 lines ...


                 if (copy_to_user((void *)arg, adgl, sizeof(struct st_ram_io)))
                         ret = -EFAULT;
                 break;
         case 2:
Error --->
                 pmem = apbs[IndexCard].RamIO + CONF_END_TEST;
                 for (i = 0; i < 10; i++)
                         writeb(0xff, pmem++);
                 writeb(adgl->data_from_pc_ready,
---------------------------------------------------------
[BUG]  seems like it.
/u1/rdg12/kernel/linux-2.4.19/drivers/message/i2o/i2o_config.c:431:ioctl_parms: 
ERROR:USER:382:431:direct deref of tainted pointer cmd

         u32 i2o_cmd = (type == I2OPARMGET ?
                                 I2O_CMD_UTIL_PARAMS_GET :
                                 I2O_CMD_UTIL_PARAMS_SET);

Start --->
         if(copy_from_user(&kcmd, cmd, sizeof(struct i2o_cmd_psetget)))

         ... DELETED 43 lines ...

         }

         put_user(len, kcmd.reslen);
         if(len > reslen)
                 ret = -ENOBUFS;
Error --->
         else if(copy_to_user(cmd->resbuf, res, len))
                 ret = -EFAULT;

         kfree(res);
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/char/applicom.c:771:ac_ioctl: 
ERROR:USER:712:771:index of apbs using needub IndexCard
         if (copy_from_user(adgl, (void *)arg,sizeof(struct st_ram_io))) {
                 kfree(adgl);
                 return -EFAULT;
         }

Start --->
         IndexCard = adgl->num_card-1;

         ... DELETED 53 lines ...

                                 byte_reset_it = readb(apbs[i].RamIO + 
RAM_IT_TO_PC);
                         }
                 }
                 break;
         case 3:
Error --->
                 pmem = apbs[IndexCard].RamIO + TIC_DES_FROM_PC;
                 writeb(adgl->tic_des_from_pc, pmem);
                 break;
         case 4:
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/char/applicom.c:775:ac_ioctl: 
ERROR:USER:712:775:index of apbs using needub IndexCard
         if (copy_from_user(adgl, (void *)arg,sizeof(struct st_ram_io))) {
                 kfree(adgl);
                 return -EFAULT;
         }

Start --->
         IndexCard = adgl->num_card-1;

         ... DELETED 57 lines ...

         case 3:
                 pmem = apbs[IndexCard].RamIO + TIC_DES_FROM_PC;
                 writeb(adgl->tic_des_from_pc, pmem);
                 break;
         case 4:
Error --->
                 pmem = apbs[IndexCard].RamIO + TIC_OWNER_TO_PC;
                 adgl->tic_owner_to_pc     = readb(pmem++);
                 adgl->numcard_owner_to_pc = readb(pmem);
                 if (copy_to_user((void *)arg, adgl,sizeof(struct st_ram_io)))
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/char/applicom.c:782:ac_ioctl: 
ERROR:USER:712:782:direct deref of needub pointer IndexCard
         if (copy_from_user(adgl, (void *)arg,sizeof(struct st_ram_io))) {
                 kfree(adgl);
                 return -EFAULT;
         }

Start --->
         IndexCard = adgl->num_card-1;

         ... DELETED 64 lines ...

                 adgl->numcard_owner_to_pc = readb(pmem);
                 if (copy_to_user((void *)arg, adgl,sizeof(struct st_ram_io)))
                         ret = -EFAULT;
                 break;
         case 5:
Error --->
                 writeb(adgl->num_card, apbs[IndexCard].RamIO + 
NUMCARD_OWNER_TO_PC);
                 writeb(adgl->num_card, apbs[IndexCard].RamIO + 
NUMCARD_DES_FROM_PC);
                 writeb(adgl->num_card, apbs[IndexCard].RamIO + 
NUMCARD_ACK_FROM_PC);
                 writeb(4, apbs[IndexCard].RamIO + DATA_FROM_PC_READY);
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/char/applicom.c:808:ac_ioctl: 
ERROR:USER:712:808:direct deref of needub pointer IndexCard
         if (copy_from_user(adgl, (void *)arg,sizeof(struct st_ram_io))) {
                 kfree(adgl);
                 return -EFAULT;
         }

Start --->
         IndexCard = adgl->num_card-1;

         ... DELETED 90 lines ...


                         printk(KERN_INFO "Prom version board %d ....... 
V%d.%d %s",
                                i+1,
                                (int)(readb(apbs[IndexCard].RamIO + 
VERS) >> 4),
                                (int)(readb(apbs[IndexCard].RamIO + VERS) & 
0xF),
Error --->
                                boardname);


                         serial = (readb(apbs[i].RamIO + SERIAL_NUMBER) << 
16) +
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/char/applicom.c:838:ac_ioctl: 
ERROR:USER:712:838:direct deref of needub pointer IndexCard
         if (copy_from_user(adgl, (void *)arg,sizeof(struct st_ram_io))) {
                 kfree(adgl);
                 return -EFAULT;
         }

Start --->
         IndexCard = adgl->num_card-1;

         ... DELETED 120 lines ...

         default:
                 printk(KERN_INFO "APPLICOM driver ioctl, unknown function 
code %d\n",cmd) ;
                 ret = -EINVAL;
                 break;
         }
Error --->
         Dummy = readb(apbs[IndexCard].RamIO + VERS);
         kfree(adgl);
         return 0;
}
---------------------------------------------------------
[BUG] minor bug since kmalloc has max allocation size
/u1/rdg12/kernel/linux-2.4.19/drivers/ide/ide-taskfile.c:1400:ide_taskfile_ioctl: 
ERROR:USER:1395:1400:passing tainted data taskout to kmalloc [MINOR]
         if (copy_from_user(req_task, (void *) arg, tasksize)) {
                 kfree(req_task);
                 return -EFAULT;
         }

Start --->
         taskout = (int) req_task->out_size;
         taskin  = (int) req_task->in_size;

         if (taskout) {
                 int outtotal = tasksize;
Error --->
                 outbuf = kmalloc(taskout, GFP_KERNEL);
                 if (outbuf == NULL) {
                         err = -ENOMEM;
                         goto abort;
---------------------------------------------------------
[BUG]
/u1/rdg12/kernel/linux-2.4.19/drivers/ide/ide-taskfile.c:1414:ide_taskfile_ioctl: 
ERROR:USER:1396:1414:passing tainted data taskin to kmalloc [MINOR]
                 kfree(req_task);
                 return -EFAULT;
         }

         taskout = (int) req_task->out_size;
Start --->
         taskin  = (int) req_task->in_size;

         ... DELETED 12 lines ...

                 }
         }

         if (taskin) {
                 int intotal = tasksize + taskout;
Error --->
                 inbuf = kmalloc(taskin, GFP_KERNEL);
                 if (inbuf == NULL) {
                         err = -ENOMEM;
                         goto abort;
---------------------------------------------------------
[BUG] Unchecked value sent to vmalloc
/u1/rdg12/kernel/linux-2.4.19/kernel/module.c:314:sys_create_module: 
ERROR:USER:293:314:passing needub data size to vmalloc [MINOR]
  * Allocate space for a module.
  */

asmlinkage unsigned long
sys_create_module(const char *name_user, size_t size)
Start --->
{

         ... DELETED 15 lines ...

         }
         if (find_module(name) != NULL) {
                 error = -EEXIST;
                 goto err1;
         }
Error --->
         if ((mod = (struct module *)module_map(size)) == NULL) {
                 error = -ENOMEM;
                 goto err1;
         }

