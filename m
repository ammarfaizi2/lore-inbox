Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbTLFJlb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 04:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbTLFJla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 04:41:30 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:38928 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S264264AbTLFJl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 04:41:29 -0500
Message-ID: <3FD1A54F.101@kolumbus.fi>
Date: Sat, 06 Dec 2003 11:45:51 +0200
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: William Lee Irwin III <wli@holomorphy.com>
Subject: Numaq in 2.4 and 2.6
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 06.12.2003 11:43:28,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 06.12.2003 11:42:38,
	Serialize complete at 06.12.2003 11:42:38
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While comparing numaq support in 2.4.23 and 2.6.0-test11 came accross 
following...

In 2.4.23 mpparse.c we do :
    phys_cpu_present_map |= apicid_to_phys_cpu_present(m->mpc_apicid);

and then launch the cpus using NMI and logical addressing in the order 
phys_cpu_present_map indicates.


In 2.6.0-test11mpparse.c we do :
    tmp = apicid_to_cpu_present(apicid);
    physids_or(phys_cpu_present_map, phys_cpu_present_map, tmp);

where apicid is the result of :
    static inline int generate_logical_apicid(int quad, int phys_apicid)
    {
        return (quad << 4) + (phys_apicid ? phys_apicid << 1 : 1);
    }

and phys_apicid == m->mpc_apicid

Again we lauch the cpus using NMI and logical addressing.


So the the set of apicids fed to do_boot_cpu() in 2.4 and 2.6 must be 
different using the same mp table. And both use logical addressing. 
Seems that 2.4 expects mpc_apicid to be something like (quad | cpu) and 
2.6 only cpu, the quad comes from the translation table.

The conclusion is that the same mp table can't work in 2.4 and 2.6? No?

--Mika


