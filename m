Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbVKJIBc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbVKJIBc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 03:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVKJIBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 03:01:32 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:4272
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751363AbVKJIBb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 03:01:31 -0500
Message-Id: <43730CA7.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 10 Nov 2005 09:02:31 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Keith Owens" <kaos@sgi.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 14/39] NLKD - kernel trace buffer access
References: Your message of "Wed, 09 Nov 2005 15:09:13 BST."            <43721119.76F0.0078.0@novell.com>   <7640.1131601492@kao2.melbourne.sgi.com>
In-Reply-To: <7640.1131601492@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Keith Owens <kaos@sgi.com> 10.11.05 06:44:52 >>>
>On Wed, 09 Nov 2005 15:09:13 +0100, 
>"Jan Beulich" <JBeulich@novell.com> wrote:
>>Debug extension implementation for NLKD to access the kernel trace
>>buffer.
>
> printk.c |  187
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 1 files changed, 187 insertions(+)
>
>This is complete overkill in printk.c.  The only change required to
>printk is to add a routine which gets the parameters that define the
>buffer, see below from KDB.  The rest of the code in your patch
belongs
>in the debugger, not in printk.

This depends on the perspective...

>#ifdef	CONFIG_KDB
>/* kdb dmesg command needs access to the syslog buffer.  do_syslog()
uses locks
> * so it cannot be used during debugging.  Just tell kdb where the
start and
> * end of the physical and logical logs are.  This is equivalent to
do_syslog(3).
> */
>void kdb_syslog_data(char *syslog_data[4])
>{
>	syslog_data[0] = log_buf;
>	syslog_data[1] = log_buf + log_buf_len;
>	syslog_data[2] = log_buf + log_end - (logged_chars < log_buf_len
? logged_chars : log_buf_len);
>	syslog_data[3] = log_buf + log_end;
>}
>#endif	/* CONFIG_KDB */

The publishing of this function allows uncontrolled access to the
otherwise (and sure purposefully) static symbols; you could as well
globalize the symbols directly. In order for KDB to be a module, this
symbol would even need to be exported. By keeping the debugger access
code in the same file, nothing gets changed visibility-wise for the
outside world.

Further, the design of the debugger extensions of NLKD calls for the
extension code to live in the place their data gets controlled at.
Consider an extension living in a module - how could the debugger access
that information?

Jan
