Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271731AbRHURbt>; Tue, 21 Aug 2001 13:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271756AbRHURbk>; Tue, 21 Aug 2001 13:31:40 -0400
Received: from smtpde02.sap-ag.de ([194.39.131.53]:4242 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S271731AbRHURb0>; Tue, 21 Aug 2001 13:31:26 -0400
From: Christoph Rohland <cr@sap.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Erik Andersen <andersee@debian.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] sysinfo compatibility
In-Reply-To: <Pine.LNX.4.21.0108211137340.1320-100000@localhost.localdomain>
Organisation: SAP LinuxLab
Date: 21 Aug 2001 19:30:04 +0200
Message-ID: <m34rr12ueb.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Tue, 21 Aug 2001, Hugh Dickins wrote:
> On 21 Aug 2001, Christoph Rohland wrote:
>> 
>> sysinfo does use a new mem_unit field if ram+swap > MAX_ULONG. That
>> breaks 2.2 compatibility for a lot machines.
>> 
>> I think it is more resonable to use the mem_unit field only if one
>> of ram or swap is bigger than MAX_ULONG. (And 2.2 was only broken
>> in that case)
> 
> It's arguable.  When I went there a few months back, I was a little
> surprised by the way it adds ram+swap (it mistakenly added in more
> before) to make that decision; but concluded it was helping callers
> who might well go on to add ram+swap, and felt no overriding reason
> to change that.  But you can certainly argue that's inappropriate
> for the kernel to do, that it should only guard the validity of
> the actual numbers it returns to the caller.  No strong feelings.

I think it's not the kernels task to fix simple user space errors by
breaking compatibility.

And I have somewhat harder feelings since we get a lot of bug reports
that our installer only detects 0M RAM when running on a 2.4 machine
while it works with the 2.2 kernel. We are talking about an ABI which
is directly imported into user space programs.

>> The appended patch implements that (and makes the logic a little
>> bit easier)
> 
> Alan, please don't apply.  The patch made the logic a lot easier,
> but sadly wrong: try what happens to totalswap 0x00120000 with
> mem_unit 0x1000 - wrong decision since 0x20000000 > 0x00120000.

Uh, oh. Try this one instead:

Greetings
		Christoph

--- 8-ac8/kernel/info.c	Tue Aug 21 09:54:02 2001
+++ u8-ac8/kernel/info.c	Tue Aug 21 13:51:42 2001
@@ -16,6 +16,7 @@
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
+	unsigned int mem_unit;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
@@ -32,47 +33,36 @@
 	si_meminfo(&val);
 	si_swapinfo(&val);
 
-	{
-		unsigned long mem_total, sav_total;
-		unsigned int mem_unit, bitcount;
-
-		/* If the sum of all the available memory (i.e. ram + swap)
-		 * is less than can be stored in a 32 bit unsigned long then
-		 * we can be binary compatible with 2.2.x kernels.  If not,
-		 * well, in that case 2.2.x was broken anyways...
-		 *
-		 *  -Erik Andersen <andersee@debian.org> */
-
-		mem_total = val.totalram + val.totalswap;
-		if (mem_total < val.totalram || mem_total < val.totalswap)
-			goto out;
-		bitcount = 0;
-		mem_unit = val.mem_unit;
-		while (mem_unit > 1) {
-			bitcount++;
-			mem_unit >>= 1;
-			sav_total = mem_total;
-			mem_total <<= 1;
-			if (mem_total < sav_total)
-				goto out;
-		}
-
-		/* If mem_total did not overflow, multiply all memory values by
-		 * val.mem_unit and set it to 1.  This leaves things compatible
-		 * with 2.2.x, and also retains compatibility with earlier 2.4.x
-		 * kernels...  */
+	/*
+	 * If the the available memory or swap is less than can be
+	 * stored in a 32 bit unsigned long then we can be binary
+	 * compatible with 2.2.x kernels.  If not, well, in that case
+	 * 2.2.x was broken anyways...
+	 *
+	 *  -Erik Andersen <andersee@debian.org> 
+	 */
+
+	mem_unit = val.mem_unit;
+	if (val.totalram  <= ULONG_MAX / mem_unit &&
+	    val.totalswap <= ULONG_MAX / mem_unit) {
+
+		/*
+		 * If mem_total did not overflow, multiply all memory
+		 * values by val.mem_unit and set it to 1.  This
+		 * leaves things compatible with 2.2.x, and also
+		 * retains compatibility with earlier 2.4.x kernels...
+		 */
 
 		val.mem_unit = 1;
-		val.totalram <<= bitcount;
-		val.freeram <<= bitcount;
-		val.sharedram <<= bitcount;
-		val.bufferram <<= bitcount;
-		val.totalswap <<= bitcount;
-		val.freeswap <<= bitcount;
-		val.totalhigh <<= bitcount;
-		val.freehigh <<= bitcount;
+		val.totalram  *= mem_unit;
+		val.freeram   *= mem_unit;
+		val.sharedram *= mem_unit;
+		val.bufferram *= mem_unit;
+		val.totalswap *= mem_unit;
+		val.freeswap  *= mem_unit;
+		val.totalhigh *= mem_unit;
+		val.freehigh  *= mem_unit;
 	}
-out:
 	if (copy_to_user(info, &val, sizeof(struct sysinfo)))
 		return -EFAULT;
 	return 0;

