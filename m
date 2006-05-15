Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWEORAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWEORAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964956AbWEORAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:00:10 -0400
Received: from havoc.gtf.org ([69.61.125.42]:10631 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S964900AbWEORAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:00:08 -0400
Date: Mon, 15 May 2006 13:00:06 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: [RFT] major libata update
Message-ID: <20060515170006.GA29555@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After much development and review, I merged a massive pile of libata
patches from Tejun Heo and Albert Lee.  This update contains the
following major libata

CHANGES:
* Rewritten error handling. This is a major piece of work, even
  though it will be rarely seen.  The new libata EH provides the
  foundation for not only improved error handling, but also new features
  such as device hotplug or command queueing. (Tejun Heo)

* PIO-based I/O is now IRQ-driven by default, rather than polled
  in a kernel thread.  The polling path will continue to exist for
  controllers that need it, and other special cases. (Albert Lee)

* Core support for command queueing (Jens Axboe, Tejun Heo)

* Support for NCQ-style command queueing (Jens Axboe, Tejun Heo)

* Increase max-sectors dramatically, for LBA48 devices (Tejun Heo?)

* Other minor changes, from myself and others.

IMPACT:
* If all goes well, this update should improve error handling,
  solve several outstanding, difficult-to-solve bugs, and provide a good
  foundation for adding some nifty features in the future.

TESTING:
* Although most drivers by count received few operational changes, the
common probe path was updated, so all drivers need fresh "yes, it sees
all my disks" regression testing.

* ahci and sata_sil24 were touched a lot, and so need additional
testing.

* sata_sil and ata_piix also need healthy re-testing of all basic
functionality.

FEEDBACK:
* Please CC linux-ide@vger.kernel.org on all emails and bug reports.

MERGE STATUS:
* Barring major problems in testing, will submit during 2.6.18 merge window.


Patch:
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata/2.6.17-rc4-git2-libata1.patch.bz2
(diff'd against 2.6.17-rc4-git2, but should apply to most recent
2.6.17-rcX[-gitY] kernels)

The 'upstream' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

contains the following updates:

 drivers/scsi/Makefile       |    2 
 drivers/scsi/ahci.c         |  436 ++++---
 drivers/scsi/ata_piix.c     |   16 
 drivers/scsi/libata-bmdma.c |  143 ++
 drivers/scsi/libata-core.c  | 2437 +++++++++++++++++++++++++++++---------------
 drivers/scsi/libata-eh.c    | 1558 ++++++++++++++++++++++++++++
 drivers/scsi/libata-scsi.c  |  423 ++++---
 drivers/scsi/libata.h       |   24 
 drivers/scsi/pdc_adma.c     |   10 
 drivers/scsi/sata_mv.c      |   30 
 drivers/scsi/sata_nv.c      |    6 
 drivers/scsi/sata_promise.c |   18 
 drivers/scsi/sata_qstor.c   |   13 
 drivers/scsi/sata_sil.c     |   65 -
 drivers/scsi/sata_sil24.c   |  615 ++++++-----
 drivers/scsi/sata_sis.c     |    2 
 drivers/scsi/sata_svw.c     |    4 
 drivers/scsi/sata_sx4.c     |   19 
 drivers/scsi/sata_uli.c     |    2 
 drivers/scsi/sata_via.c     |    2 
 drivers/scsi/sata_vsc.c     |   15 
 drivers/scsi/scsi.c         |   18 
 drivers/scsi/scsi_error.c   |    3 
 drivers/scsi/scsi_lib.c     |    2 
 drivers/scsi/scsi_priv.h    |    1 
 include/linux/ata.h         |   34 
 include/linux/libata.h      |  379 ++++--
 include/scsi/scsi_cmnd.h    |    1 
 include/scsi/scsi_eh.h      |    1 
 include/scsi/scsi_host.h    |    1 
 30 files changed, 4634 insertions(+), 1646 deletions(-)

Albert Lee:
      libata: interrupt driven pio for libata-core
      libata: interrupt driven pio for LLD
      libata irq-pio: add comments and cleanup
      libata irq-pio: rename atapi_packet_task() and comments
      libata irq-pio: simplify if condition in ata_dataout_task()
      libata irq-pio: cleanup ata_qc_issue_prot()
      libata: move atapi_send_cdb() and ata_dataout_task()
      [libata irq-pio] reorganize ata_pio_sector() and __atapi_pio_bytes()
      [libata irq-pio] reorganize "buf + offset" in ata_pio_sector()
      [libata irq-pio] use PageHighMem() to optimize the kmap_atomic() usage
      libata irq-pio: misc fixes
      libata irq-pio: merge the ata_dataout_task workqueue with ata_pio_task workqueue
      libata irq-pio: eliminate unnecessary queuing in ata_pio_first_block()
      libata irq-pio: add read/write multiple support
      libata-dev: determine err_mask when error is found
      libata-dev: filter out noisy ATAPI error messages
      libata-dev: Fix array index value in ata_rwcmd_protocol()
      libata-dev: Use new ata_queue_pio_task() for PIO polling task
      libata-dev: Use new AC_ERR_* flags
      libata-dev: Minor comment fix
      libata-dev: recognize WRITE_MULTI_FUA_EXT for r/w multiple
      libata-dev: Remove trailing whitespaces
      libata-dev: Fix merge problem with upstream
      libata-dev: Remove atapi_packet_task()
      libata-dev: Move out the HSM code from ata_host_intr()
      libata-dev: Minor fix for ata_hsm_move() to work with ata_host_intr()
      libata-dev: Let ata_hsm_move() work with both irq-pio and polling pio
      libata-dev: Convert ata_pio_task() to use the new ata_hsm_move()
      libata-dev: Cleanup unused enums/functions
      libata-dev: ata_check_atapi_dma() fix for ATA_FLAG_PIO_POLLING LLDDs
      libata-dev: Make the the in_wq check as an inline function
      libata-dev: irq-pio minor fixes (respin)
      libata-dev: fix the device err check sequence (respin)
      libata-dev: wait idle after reading the last data block
      libata-dev: print out information for ATAPI devices with CDB interrupts
      libata-dev: handle DRQ=1 ERR=1 (revised)
      libata-dev: irq-pio minor fix
      libata-dev: irq-pio minor fix 2
      libata: convert ATAPI_ENABLE_DMADIR to module parameter

Bastiaan Jacques:
      ahci: add support for VIA VT8251

Jeff Garzik:
      [libata irq-pio] build fix
      [libata pdc_adma] update for removal of ATA_FLAG_NOINTR
      [libata pdc_adma] fix for new irq-driven PIO code
      [libata sata_mv] IRQ PIO build fix
      [libata] irq-pio: fix breakage related to err_mask merge
      [libata sata_promise] irq_pio: fix merge bug
      [libata] build fix after merging some pre-packet_task-removal code
      [libata irq-pio] s/assert/WARN_ON/
      [libata] build fix after cdb_len move
      sata_vsc build fix
      libata: irq-pio build fixes
      [libata] irq-pio: fix build breakage
      [libata] irq-pio: Fix merge mistake
      [libata] kill bogus cut-n-pasted comments in three drivers
      [libata] bump versions
      libata: Fix EH merge difference between this branch and upstream.
      libata: Add helper ata_shost_to_port()

Luben Tuikov:
      SCSI: Introduce scsi_req_abort_cmd (REPOST)

Tejun Heo:
      libata: increase LBA48 max sectors to 65535
      libata: fix ata_set_mode() return value
      libata: make ata_bus_probe() return negative errno on failure
      libata: separate out ata_spd_string()
      libata: convert do_probe_reset() to ata_do_reset()
      libata: implement ata_dev_enabled and disabled()
      libata: make ata_set_mode() handle no-device case properly
      libata: reorganize ata_set_mode()
      libata: don't disable devices from ata_set_mode()
      libata: preserve SATA SPD setting over hard resets
      libata: implement ata_dev_absent()
      libata: implement ap->sata_spd_limit and helpers
      libata: use SATA speed down in ata_drive_probe_reset()
      libata: add 5s sleep between resets
      libata: implement ata_down_xfermask_limit()
      libata: improve ata_bus_probe()
      libata: consider disabled devices in ata_dev_xfermask()
      libata: report device number when PIO fails
      libata: ata_dev_revalidate() printk update
      libata: ATA_FLAG_IN_EH is not used, kill it
      libata: clean up constants
      libata: rename ATA_FLAG_PORT_DISABLED to ATA_FLAG_DISABLED
      libata: clear only affected flags during ata_dev_configure()
      libata: clear ATA_DFLAG_PIO before setting it
      libata: add ATA_QCFLAG_IO
      libata: pass qc around intead of ap during PIO
      libata: always generate sense if qc->err_mask is non-zero
      libata: don't read TF directly from sense generation functions
      libata: add @cdb to ata_exec_internal()
      libata: dec scmd->retries for qcs with zero err_mask
      libata: separate out libata-eh.c
      libata: make some libata-core routines extern
      libata: print SControl in SATA link status info message
      ahci: do not fail softreset if PHY reports no device
      libata: set default cbl in probeinit
      libata: kill @verbose from ata_reset_fn_t
      libata: make reset methods complain when they fail
      sata_sil24: fix timeout calculation in sil24_softreset
      sata_sil24: better error message from softreset
      libata: implement ata_wait_register()
      ahci: use ata_wait_register()
      sata_sil24: use ata_wait_register()
      libata: disable failed devices only once in ata_bus_probe()
      libata: cosmetic update to ata_bus_probe()
      libata: export ata_set_sata_spd()
      sata_sil24: typo fix
      sata_sil24: rename PORT_IRQ_SDB_FIS to PORT_IRQ_SDB_NOTIFY
      sata_sil24: add more constants
      sata_sil24: consolidate host flags into SIL24_COMMON_FLAGS
      sata_sil24: implement loss of completion interrupt on PCI-X errta fix
      sata_sil24: implement sil24_init_port()
      sata_sil24: put port into known state before softresetting
      sata_sil24: kill 10ms sleep in softreset
      sata_sil24: reimplement hardreset
      sata_sil24: don't do hardreset during driver initialization
      sata_sil24: fix on-memory structure byteorder
      sata_sil24: enable 64bit
      SCSI: implement shost->host_eh_scheduled
      libata: silly fix in ata_scsi_start_stop_xlat()
      libata: rename ata_down_sata_spd_limit() and friends
      ahci: hardreset classification fix
      libata: unexport ata_scsi_error()
      libata: kill duplicate prototypes
      libata: fix ->phy_reset class code handling in ata_bus_probe()
      libata: clear ap->active_tag atomically w.r.t. command completion
      libata: hold host_set lock while finishing internal qc
      libata: use preallocated buffers
      libata: move ->set_mode() handling into ata_set_mode()
      libata: remove postreset handling from ata_do_reset()
      libata: implement qc->result_tf
      sata_sil24: update TF image only when necessary
      libata: init ap->cbl to ATA_CBL_SATA early
      libata: implement new SCR handling and port on/offline functions
      libata: use new SCR and on/offline functions
      libata: kill old SCR functions and sata_dev_present()
      libata: add dev->ap
      libata: use dev->ap
      libata: implement ATA printk helpers
      libata: use ATA printk helpers
      libata-eh-fw: add flags and operations for new EH
      libata-eh-fw: clear SError in ata_std_postreset()
      libata-eh-fw: use special reserved tag and qc for internal commands
      libata-eh-fw: update ata_qc_from_tag() to enforce normal/EH qc ownership
      libata-eh-fw: implement new EH scheduling via error completion
      libata-eh-fw: implement ata_port_schedule_eh() and ata_port_abort()
      libata-eh-fw: implement freeze/thaw
      libata-eh-fw: implement new EH scheduling from PIO
      libata-eh-fw: update ata_scsi_error() for new EH
      libata-eh-fw: update ata_exec_internal() for new EH
      libata-eh-fw: update SCSI command completion path for new EH
      libata-eh: add ATA and libata flags for new EH
      libata-eh: implement dev->ering
      libata-eh: implement ata_eh_info and ata_eh_context
      libata-eh: implement new EH
      libata-eh: implement BMDMA EH
      ata_piix: convert to new EH
      sata_sil: convert to new EH
      ahci: convert to new EH
      ahci: add PIOS interim interrupt handling
      sata_sil24: convert to new EH
      libata: fix irq-pio merge
      libata-ncq: add NCQ related ATA/libata constants and macros
      libata-ncq: pass ata_scsi_translate() return value to SCSI midlayer
      libata-ncq: rename ap->qactive to ap->qc_allocated
      libata-ncq: implement ap->qc_active, ap->sactive and complete helper
      libata-ncq: implement NCQ command translation and exclusion
      libata-ncq: update EH to handle NCQ
      libata-ncq: implement NCQ device configuration
      ahci: clean up AHCI constants in preparation for NCQ
      ahci: add HOST_CAP_NCQ constant
      ahci: kill pp->cmd_tbl_sg
      ahci: implement NCQ suppport
      sata_sil24: implement NCQ support

