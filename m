Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUCERJA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 12:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbUCERJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 12:09:00 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:19454 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262669AbUCERIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 12:08:35 -0500
Date: Fri, 5 Mar 2004 09:08:32 -0800
From: "H. J. Lu" <hjl@lucon.org>
To: linux-kernel@vger.kernel.org, David Mosberger <davidm@napali.hpl.hp.com>,
       "Luck, Tony" <tony.luck@intel.com>, gcc@gcc.gnu.org,
       GNU C Library <libc-alpha@sources.redhat.com>
Subject: Re: binutils 2.15.90.0.1 break ia64 kernel crosscompiling
Message-ID: <20040305170832.GA16182@lucon.org>
References: <20040305142725.GA20926@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305142725.GA20926@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2004 at 03:27:25PM +0100, Herbert Poetzl wrote:
> 
> Hi Folks!
> 
> upgraded my Cross Compiling Toolchain[1] to binutils 2.15.90.0.1, 
> recompiled gcc 3.3.3 (just to make sure), and now linux 2.6.3
> doesn't compile for ia64 anymore ...
> 
> here is th funny part of the complete error log[2]
> 
> ------------------------------------------------------------------
>   {standard input}: Assembler messages:
>   {standard input}:1268: Internal error!
>   Assertion failure in md_assemble at config/tc-ia64.c line 10013.
>   Please report this bug.
> ------------------------------------------------------------------
> 
> so we are now down from 6 to 5 of 20 archs which compile 2.6.3
> with default config, will soon try with 2.6.4-rc*
> 

I checked in this patch. Please test it as much as you can on ia64.


H.J.
----
2004-03-04  H.J. Lu  <hongjiu.lu@intel.com>

	* config/tc-ia64.c (md_assemble): Properly handle NULL
	align_frag.
	(ia64_handle_align): Don't abort if failed to add a stop bit.

--- gas/config/tc-ia64.c.align	2004-03-03 11:49:14.000000000 -0800
+++ gas/config/tc-ia64.c	2004-03-04 15:19:37.000000000 -0800
@@ -10010,9 +10010,12 @@ md_assemble (str)
 	  while (align_frag->fr_type != rs_align_code)
 	    {
 	      align_frag = align_frag->fr_next;
-	      assert (align_frag);
+	      if (!align_frag)
+		break;
 	    }
-	  if (align_frag->fr_next == frag_now)
+	  /* align_frag can be NULL if there are directives in
+	     between.  */
+	  if (align_frag && align_frag->fr_next == frag_now)
 	    align_frag->tc_frag_data = 1;
 	}
 
@@ -10872,8 +10875,16 @@ ia64_handle_align (fragp)
   if (!bytes && fragp->tc_frag_data)
     {
       if (fragp->fr_fix < 16)
+#if 1
+	/* FIXME: It won't work with
+	   .align 16
+	   alloc r32=ar.pfs,1,2,4,0
+	 */
+	;
+#else
 	as_bad_where (fragp->fr_file, fragp->fr_line,
 		      _("Can't add stop bit to mark end of instruction group"));
+#endif
       else
 	/* Bundles are always in little-endian byte order. Make sure
 	   the previous bundle has the stop bit.  */
