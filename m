Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267820AbUHPRpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267820AbUHPRpP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 13:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267822AbUHPRpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 13:45:14 -0400
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:30095 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S267820AbUHPRoy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 13:44:54 -0400
Date: Mon, 16 Aug 2004 19:44:50 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Wendel <jwendel10@comcast.net>
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
Message-ID: <20040816174450.GA3754@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1092661385.20528.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> ha scritto:
> On Llu, 2004-08-16 at 13:38, Marc Ballarin wrote:
>> Due to the newly added command filtering, you now need to run cdrecord as
>> root. Since cdrecord will drop root privileges before accessing the drive,
>> setuid root won't help
> 
> cdrecord should be fine. k3b is issuing something not on the filter
> list.

cdrecord (from debian) does not work.

>> This patch restores the behaviour of previous kernels, security issues included:
> 
> Like allowing any user to erase your drive firmware. What you could do
> which is much more useful is printk the command byte that gets refused
> and see if you can pin down what commands are being blocked that
> are needed by K3B 

kronos:~$ cdrecord --version
Cdrecord-Clone 2.01a34 (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg Schilling
NOTE: this version of cdrecord is an inofficial (modified) release of cdrecord
      and thus may have bugs that are not present in the original version.
      Please send bug reports and support requests to <cdrtools@packages.debian.org>.
      The original author should not be bothered with problems of this version.

This is mkisofs ... | cdrecord dev=/dev/hdd -tao - (as non-root user, I
have write access to the device):

verify_command: failed cmd 0x46
verify_command: failed cmd 0x46
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x5c

This is cdrecord dev=/dev/hdd blank=fast:

verify_command: failed cmd 0x46
verify_command: failed cmd 0x46
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x5c
verify_command: failed cmd 0x1e
verify_command: failed cmd 0x1
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x55
verify_command: failed cmd 0x35
verify_command: failed cmd 0x55
verify_command: failed cmd 0x1e

0x55 is MODE_SELECT_10 (not listed in verify_command)
0x01 is REZERO_UNIT (not listed in verify_command)
0x1e is ALLOW_MEDIUM_REMOVAL (not listed in verify_command)
0x35 is SYNCHRONIZE_CACHE (not listed in verify_command)

I can't find 0x46 in scsi/scsi.h... but from cdrecord sources
(cdrecord/scsi_mmc.c):

/*
 * Get feature codes
 */
EXPORT int
get_configuration(scgp, bp, cnt, st_feature, rt)
        SCSI    *scgp;
        caddr_t bp;
        int     cnt;
        int     st_feature;
        int     rt;
{
        register struct scg_cmd *scmd = scgp->scmd;

        fillbytes((caddr_t)scmd, sizeof (*scmd), '\0');
        scmd->addr = bp;
        scmd->size = cnt;
        scmd->flags = SCG_RECV_DATA|SCG_DISRE_ENA;
        scmd->cdb_len = SC_G1_CDBLEN;
        scmd->sense_len = CCS_SENSE_LEN;
  --->  scmd->cdb.g1_cdb.cmd = 0x46; <--- 
        scmd->cdb.g1_cdb.lun = scg_lun(scgp);
        if (rt & 1)
                scmd->cdb.g1_cdb.reladr  = 1;
        if (rt & 2)
                scmd->cdb.g1_cdb.res  =  1;

        i_to_2_byte(scmd->cdb.g1_cdb.addr, st_feature);
        g1_cdblen(&scmd->cdb.g1_cdb, cnt);

        scgp->cmdname = "get_configuration";
        
        return (scg_cmd(scgp));
}

Luca
-- 
Home: http://kronoz.cjb.net
You and me baby ain't nothin' but mammals
So let's do it like they do on the Discovery Channel
