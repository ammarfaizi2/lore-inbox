Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbUASLic (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 06:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbUASLh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 06:37:56 -0500
Received: from f25.mail.ru ([194.67.57.151]:12811 "EHLO f25.mail.ru")
	by vger.kernel.org with ESMTP id S264575AbUASLf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 06:35:26 -0500
From: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= <kksx@mail.ru>
To: =?koi8-r?Q?=22?=Paul Mackerras=?koi8-r?Q?=22=20?= 
	<paulus@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sort exception tables
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [195.133.213.194]
Date: Mon, 19 Jan 2004 14:35:22 +0300
Reply-To: =?koi8-r?Q?=22?=Kirill Korotaev=?koi8-r?Q?=22=20?= 
	  <kksx@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AiXgg-0005hf-00.kksx-mail-ru@f25.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +const struct exception_table_entry *
> +search_extable(const struct exception_table_entry *first,
> +	       const struct exception_table_entry *last,
> +	       unsigned long value)
> +{
> +        while (first <= last) {
> +		const struct exception_table_entry *mid;
> +		long diff;
> +
> +		mid = (last - first) / 2 + first;
> +		diff = mid->insn - value;
> +                if (diff == 0)
> +                        return mid;
> +                else if (diff < 0)
> +                        first = mid+1;
> +                else
> +                        last = mid-1;
> +        }
> +        return NULL;
> +}
Please, then if you patch this place add these changes:

         while (first <= last) {
                const struct exception_table_entry *mid;
-               long diff;

                mid = (last - first) / 2 + first;
-               diff = mid->insn - value;
-                if (diff == 0)
+               if (mid->insn == value)
                         return mid->fixup;
-                else if (diff < 0)
+               else if (mid->insn < value)
                         first = mid+1;
                 else
                         last = mid-1;

since using long diff is incorrect here when distance between addresses is greater than 2GB on i386. (e.g. 4gb split).

Kirill

