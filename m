Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266156AbUBDDsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 22:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266286AbUBDDsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 22:48:16 -0500
Received: from science.horizon.com ([192.35.100.1]:36427 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S266156AbUBDDsL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 22:48:11 -0500
Date: 4 Feb 2004 03:48:10 -0000
Message-ID: <20040204034810.29593.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.1 -- take two] Add CRC32C chksums to crypto and lib
Cc: jmorris@redhat.com, Valdis.Kletnieks@vt.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I could have *sworn* that abandoning something to the public
> domain prohibited any disclaimer-of-liability clauses - the original
> reason for the MIT X copyright was because they couldn't disclaim
> liability if they let it into the public domain.  It's the same basic
> "by copying, you agree to our terms" copyright that essentially all
> open-source depends on.
>
> And if it's in the public domain, they don't have to agree to your terms,
> and thus you can't enforce that liability disclaimer..

> Placing the code in the public domain then adding additional rights seems 
> to be inherently conflicted.
>
> People will pay for distribution of the code, so these additional rights 
> would not be acceptable anyway.

If there's a problem, then change it - like delete the disclaimer.
The code is too trivial to worry about.

I'll rewrite it AGAIN if anybody needs a legally-clean version; it takes
about 5 minutes, and a few more for testing.

/*
 * poly is the polynomial, with bit n corresponding to the x^(31-n)
 * coefficient and the x^32 coefficient implicitly 1.
 */
void __attribute__((nonnull))
make_crc32_table_le(u32 table[256], u32 poly)
{
	unsigned i, j;
	u32 crc = 1;

	table[0] = 0;
	for (i = 1; i < 256; i *= 2) {
		crc = (crc >> 1) ^ (crc & 1 ? poly : 0);
		for (j = 0; j < i; j++)
			table[i+j] = crc ^ table[j];
	}
}


/* Append the given (data, len) to the computed CRC.
 * For most protocols, initialize crc to -(u32)1 and invert it
 * before appending to the data.  The final CRC can be checked
 * by repeating the generation computation, or by computing the CRC again
 * over the entire stream (including the first CRC) and comparing to
 * a known value.  If the final CRC is not inverted, the result should
 * be zero.  If the final CRC is inverted, the result should be a fixed
 * non-zero value.
 */
u32 __attribute__((nonnull(1)))
calc_crc32_le(u32 const table[256], u8 data, unsigned len, u32 crc)
{
	while (len--)
		crc = (crc >> 8) ^ table[(u8)(crc ^ *data++)];
	return crc;
}

/*
 * poly is the polynomial, with bit n corresponding to the x^n
 * coefficient and the x^32 coefficient implicitly 1.
 */
void __attribute__((nonnull))
make_crc32_table_be(u32 table[256], u32 poly)
{
	unsigned i, j;
	u32 crc = 0x80000000;

	table[0] = 0;
	for (i = 128; i; i /= 2) {
		crc = (crc << 1) ^ (crc & 0x80000000 ? poly : 0);
		for (j = 0; j < 256; j += 2*i)
			table[i+j] = crc ^ table[j];
	}
}


u32 __attribute__((nonnull))
calc_crc32_be(u32 const table[256], u8 data, unsigned len, u32 crc)
{
	while (len--)
		crc = (crc << 8) ^ table[(u8)((crc >> 24) ^ *data++)];
	return crc;
}


Okay, that took 10 minutes and 5 seconds.  And it's not tested.
But it's pretty straightforweard.
