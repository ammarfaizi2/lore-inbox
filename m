Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751950AbWCFIId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbWCFIId (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 03:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWCFIId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 03:08:33 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:19227
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751950AbWCFIId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 03:08:33 -0500
Message-Id: <440BFC1C.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 06 Mar 2006 09:08:44 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] adjust /dev/{kmem,mem,port} write handlers
References: <44081B03.76F0.0078.0@novell.com> <20060304221550.6892c7ba.akpm@osdl.org>
In-Reply-To: <20060304221550.6892c7ba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> @@ -514,11 +510,10 @@ static ssize_t write_kmem(struct file * 
>>  			if (len) {
>>  				written = copy_from_user(kbuf, buf, len);
>>  				if (written) {
>> -					ssize_t ret;
>> -
>> +					if (wrote + virtr)
>> +						break;
>>  					free_page((unsigned long)kbuf);
>> -					ret = wrote + virtr + (len - written);
>> -					return ret ? ret : -EFAULT;
>> +					return -EFAULT;
>>  				}
>>  			}
>>  			len = vwrite(kbuf, (char *)p, len);
>
>
>I think write_kmem() still isn't quie right - it needs to update `p' (and
>hence *ppos) to account for a partial copy_from_user().  (Please double-check)

No, I disagree. The actual write happens with the call to vwrite(), independent of the reading of the user buffer. If
any adjustment might be needed, then it would be to account for the potential of vwrite() (and similarly vread()) to
return 0, resulting in no progress being possible to be made anymore.

Jan
