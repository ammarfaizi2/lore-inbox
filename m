Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263603AbUD1DyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUD1DyY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 23:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbUD1DyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 23:54:23 -0400
Received: from chococat.sd.dreamhost.com ([66.33.206.16]:1675 "EHLO
	chococat.sd.dreamhost.com") by vger.kernel.org with ESMTP
	id S263603AbUD1DyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 23:54:16 -0400
Message-ID: <3197.171.64.70.113.1083124455.spork@webmail.coverity.com>
Date: Tue, 27 Apr 2004 20:54:15 -0700 (PDT)
Subject: [CHECKER] Implementation inconsistencies involving writes
From: "Ken Ashcraft" <ken@coverity.com>
To: linux-kernel@vger.kernel.org, linux@coverity.com
Cc: davem@redhat.com, kraxel@goldbach.in-berlin.de, linux@brodo.de,
       acme@conectiva.com.br, tangf@eyetap.org, mdharm-usb@one-eyed-alien.net
Reply-To: ken@coverity.com
User-Agent: DreamHost Webmail
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
References: 
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry if you receive this twice.  The first one snuck off with out a
subject line.)

I'm trying to cross check implementations of the same interface for
errors.  I assume that if functions are assigned to the same function
pointer, they are implementations of a common interface and should be
consistent with each other.  In this case, I'm looking at which arguments
are written by the implementations.  If one implementation fails to write
a field of a struct passed in, but the other implementations do write that
field, I'll report it.

If you find yourself CC'd on this email, it is because I think that you
are the maintainer of code that contains one of the error reports.  Search
for your email address to find the appropriate report.  If there is a
report without an email address, it means that I couldn't find the
maintainer.  Please forward if you know who the code belongs to.

In each of the reports below, I give an example implementation that does
write the argument.  That is followed by an implementation that fails to
write the argument.

This checker is experimental, so be warned that these reports may be
false.  I would very much appreciate your feedback.

Thanks,
Ken Ashcraft

#  Total   = 7
# BUGs        |        File Name
1        |        /fs/affs/super.c
1        |        /drivers/usb/storage/scsiglue.c
1        |        /arch/i386/kernel/cpu/cpufreq/longrun.c
1        |        /drivers/net/irda/mcp2120-sir.c
1        |        /drivers/net/wireless/wl3501_cs.c
1        |        /drivers/media/video/bttv-cards.c
1        |        /drivers/net/sunhme.c
---------------------------------------------------------
[BUG] (davem@redhat.com) not writing cmd->advertising

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/8139cp.c:1352:cp_get_settings:
NOTE:WRITE: Writing arg (*cmd).advertising
[EXAMPLE=ethtool_ops.get_settings-1.deref.advertising]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/sunhme.c:2429:hme_get_settings:
ERROR:WRITE: Not writing arg
[COUNTER=ethtool_ops.get_settings-1.deref.advertising]  [fit=9] [fit_fn=1]
[fn_ex=0] [fn_counter=1] [ex=10] [counter=1] [z = -0.622543017479467]
[fn-z = -4.35889894354067]

        spin_unlock_irq(&hp->happy_lock);
}

/* Ethtool support... */

Error --->
static int hme_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
{
        struct happy_meal *hp = dev->priv;

---------------------------------------------------------
[BUG] <kraxel@goldbach.in-berlin.de> not writing v->mode.  the examples
are almost identical to each other

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/media/video/bttv-cards.c:3338:gvbctv3pci_audio:
NOTE:WRITE: Writing arg (*v).mode
[EXAMPLE=tvcard.audio_hook-1.deref.mode]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/media/video/bttv-cards.c:3275:winview_audio:
ERROR:WRITE: Not writing arg [COUNTER=tvcard.audio_hook-1.deref.mode] 
[fit=10] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=9] [counter=1] [z =
-0.72547625011001] [fn-z = -4.35889894354067]


/* ----------------------------------------------------------------------- */
/* winview                                                                 */


Error --->
void winview_audio(struct bttv *btv, struct video_audio *v, int set) {
        /* PT2254A programming Jon Tombs, jon@gte.esi.us.es */
        int bits_out, loops, vol, data;
---------------------------------------------------------
[BUG] <linux@brodo.de> not writing policy->governor. looks like it is
necessary to write a default value there.

example:
/home/kash/linux/2.6.3/linux-2.6.3/arch/i386/kernel/cpu/cpufreq/acpi.c:291:acpi_cpufreq_cpu_init:
NOTE:WRITE: Writing arg (*policy).governor
[EXAMPLE=cpufreq_driver.init-0.deref.governor]

/home/kash/linux/2.6.3/linux-2.6.3/arch/i386/kernel/cpu/cpufreq/longrun.c:223:longrun_cpu_init:
ERROR:WRITE: Not writing arg
[COUNTER=cpufreq_driver.init-0.deref.governor]  [fit=11] [fit_fn=1]
[fn_ex=0] [fn_counter=1] [ex=9] [counter=1] [z = -0.72547625011001] [fn-z
= -4.35889894354067]

        return 0;
}



Error --->
static int longrun_cpu_init(struct cpufreq_policy *policy)
{
        int                     result = 0;

---------------------------------------------------------
[BUG] <acme@conectiva.com.br> suspicious.  examples clear DEV_CONFIG bit
of link->state when it is set.  This one says that the link will be marked
so that it can be deleted later.  However, I don't see any marking when
the DEV_CONFIG bit is set.

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/ide/legacy/ide-cs.c:188:ide_detach:
NOTE:WRITE: Writing arg (*link).state
[EXAMPLE=pcmcia_driver.detach-0.deref.state]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/wireless/wl3501_cs.c:1552:wl3501_detach:
ERROR:WRITE: Not writing arg [COUNTER=pcmcia_driver.detach-0.deref.state]
 [fit=13] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=22] [counter=2] [z =
-0.749268649265355] [fn-z = -4.35889894354067]
 *
 * This deletes a driver "instance". The device is de-registered with Card
* Services. If it has been released, all local data structures are freed.
* Otherwise, the structures will be freed when the device is released. */

Error --->
static void wl3501_detach(dev_link_t *link)
{
        dev_link_t **linkp;

---------------------------------------------------------
[BUG](tangf@eyetap.org) not setting dev->speed

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/irda/act200l-sir.c:241:act200l_reset:
NOTE:WRITE: Writing arg (*dev).speed
[EXAMPLE=dongle_driver.reset-0.deref.speed]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/net/irda/mcp2120-sir.c:184:mcp2120_reset:
ERROR:WRITE: Not writing arg [COUNTER=dongle_driver.reset-0.deref.speed] 
[fit=14] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=8] [counter=1] [z =
-0.841191024192059] [fn-z = -4.35889894354067]
 */

#define MCP2120_STATE_WAIT1_RESET        (SIRDEV_STATE_DONGLE_RESET+1)
#define MCP2120_STATE_WAIT2_RESET        (SIRDEV_STATE_DONGLE_RESET+2)


Error --->
static int mcp2120_reset(struct sir_dev *dev)
{
        unsigned state = dev->fsm.substate;
        unsigned delay = 0;
---------------------------------------------------------
[BUG] (mdharm-usb@one-eyed-alien.net) not writing sdev->ordered_tags.  All
the examples use scsi_adjust_queue_depth() to do this.

example:
/home/kash/linux/2.6.3/linux-2.6.3/drivers/scsi/53c700.c:1978:NCR_700_slave_configure:
NOTE:WRITE: Writing arg (*SDp).ordered_tags
[EXAMPLE=scsi_host_template.slave_configure-0.deref.ordered_tags]

/home/kash/linux/2.6.3/linux-2.6.3/drivers/usb/storage/scsiglue.c:67:slave_configure:
ERROR:WRITE: Not writing arg
[COUNTER=scsi_host_template.slave_configure-0.deref.ordered_tags] [SMALL]
[fit=21] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=6] [counter=1] [z =
-1.12724296038136] [fn-z = -4.35889894354067]
static const char* host_info(struct Scsi_Host *host)
{
        return "SCSI emulation for USB Mass Storage devices";
}


Error --->
static int slave_configure (struct scsi_device *sdev)
{
        /* Scatter-gather buffers (all but the last) must have a length
         * divisible by the bulk maxpacket size.  Otherwise a data packet
---------------------------------------------------------
[BUG] doesn't initialize buf->f_ffree

example:
/home/kash/linux/2.6.3/linux-2.6.3/fs/adfs/super.c:209:adfs_statfs:
NOTE:WRITE: Writing arg (*buf).f_ffree
[EXAMPLE=super_operations.statfs-1.deref.f_ffree]

/home/kash/linux/2.6.3/linux-2.6.3/fs/affs/super.c:529:affs_statfs:
ERROR:WRITE: Not writing arg
[COUNTER=super_operations.statfs-1.deref.f_ffree]  [fit=17] [fit_fn=1]
[fn_ex=0] [fn_counter=1] [ex=6] [counter=1] [z = -1.12724296038136] [fn-z
= -4.35889894354067]
        }
        return 0;
}

static int

Error --->
affs_statfs(struct super_block *sb, struct kstatfs *buf)
{
        int                 free;




