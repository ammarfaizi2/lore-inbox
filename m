Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWERI2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWERI2z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 04:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWERI2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 04:28:55 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:21727 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750812AbWERI2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 04:28:54 -0400
Message-ID: <446C3030.2040303@bull.net>
Date: Thu, 18 May 2006 10:28:32 +0200
From: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en, fr, hu
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: write_out_data in JBD
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 10:31:50,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 10:32:02,
	Serialize complete at 18/05/2006 10:32:02
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen,

Here is a code fragment starting at "write_out_data:" in
"journal_commit_transaction()":

Let's assume that there is a single "jh" on the list.

write_out_data:
   while (commit_transaction->t_sync_datalist) {

       jh = commit_transaction->t_sync_datalist;
       commit_transaction->t_sync_datalist = jh->b_tnext;

       // "commit_transaction->t_sync_datalist" happens always
       // to point at our single "jh"

       bh = jh2bh(jh);

       // Assume not locked
       // Assume dirty

       if (buffer_dirty(bh)) {
           get_bh(bh);
           wbuf[bufs++] = bh;
           if (bufs == journal->j_wbufsize) {
               ...
               goto write_out_data;
           }
       } else ...
   }

I think our single "jh" will be put on "wbuf[]" repeatedly
("journal->j_wbufsize" times).

Regards,

Zoltan Menyhart

