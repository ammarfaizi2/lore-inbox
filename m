Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263546AbTH3Mnf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 08:43:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTH3Mnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 08:43:35 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:45320 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S263546AbTH3Mnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 08:43:33 -0400
Message-ID: <3F509D82.5050409@kolumbus.fi>
Date: Sat, 30 Aug 2003 15:50:10 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: swsusp broken
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 30.08.2003 15:45:07,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 30.08.2003 15:44:27,
	Serialize complete at 30.08.2003 15:44:27
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.0-test4 software suspend seems to be badly broken...looking at it 
(relevant code included below), no wonder. pm_suspend_disk() calls 
swsusp_save(), which is is essentially a nop. The intention was clearly 
that after resume control would return from swsusp_save(), which isn't 
the case, instead we return from swsusp_write(), and power down again!!!

--Mika

--------------------------------------------------------------------------
static int pm_suspend_disk(void)
{
    int error;

    pr_debug("PM: Attempting to suspend to disk.\n");
    if (pm_disk_mode == PM_DISK_FIRMWARE)
        return pm_ops->enter(PM_SUSPEND_DISK);

    if (!have_swsusp)
        return -EPERM;

    pr_debug("PM: snapshotting memory.\n");
    in_suspend = 1;
    if ((error = swsusp_save()))
        goto Done;

    if (in_suspend) {
        pr_debug("PM: writing image.\n");
        error = swsusp_write();
        if (!error)
            error = power_down(pm_disk_mode);
        pr_debug("PM: Power down failed.\n");
    } else
        pr_debug("PM: Image restored successfully.\n");
    swsusp_free();
 Done:
    return error;
}
----------------------------------------------------------------------------

/**
 *    swsusp_save - Snapshot memory
 */

int swsusp_save(void)
{
#if defined (CONFIG_HIGHMEM) || defined (COFNIG_DISCONTIGMEM)
    printk("swsusp is not supported with high- or discontig-mem.\n");
    return -EPERM;
#endif
    return 0;
}


