Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129687AbQKHA37>; Tue, 7 Nov 2000 19:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129295AbQKHA3t>; Tue, 7 Nov 2000 19:29:49 -0500
Received: from 4dyn176.delft.casema.net ([195.96.105.176]:63498 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129716AbQKHA3h>; Tue, 7 Nov 2000 19:29:37 -0500
Message-Id: <200011080029.BAA06851@cave.bitwizard.nl>
Subject: Re: malloc(1/0) ??
In-Reply-To: <20001107104634.G13151@mea-ext.zmailer.org> from Matti Aarnio at
 "Nov 7, 2000 10:46:34 am"
To: Matti Aarnio <matti.aarnio@zmailer.org>
Date: Wed, 8 Nov 2000 01:29:27 +0100 (MET)
CC: Lyle Coder <x_coder@hotmail.com>, David Schwartz <davids@webmaster.com>,
        RAJESH BALAN <atmproj@yahoo.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matti Aarnio wrote:
> needed size is bound to get user burned.   malloc(0)  is insane thing
> (IMO), but at least glibc supports it for some reason.  Likely just due
> to padding and minimum size issues.

Part of the desing of the C language and the library is intended to
make boundary conditions go well automatically. 

So, a program that does:

	fscanf (file, "%d", &numsquares);
	squares = malloc (sizeof (struct square) * numsquares);
	for (i=0;i<numsquares; i++)
	   read_square_from_file (file, &squares[i]);

	fscanf (file, "%d", &numtriangles);
	triangles = malloc (sizeof (struct triangle) * numtriangles);
	for (i=0;i<numtriangles; i++)
	   read_triangle_from_file (file, &triangles[i]);


	[use the stuff....]

	free (triangles);
	free (squares);

should work. See, the "for" loop nicely executes 0 times when
numtriangles is zero. Similarly, malloc/free don't have any
"exception" case for the "numtriangles is zero" case.

Now, at first you might say that "malloc" could return NULL, as long
as "free" accepts it. However, that's not true: The result of the
malloc call can and acutally should be checked for "NULL", and the
program might abort.

A valid implementation MAY:
	

	#define NIL ((void *) 1)

	void * malloc (int size)
	{
	if (size == 0) NIL;
	[....]
	}

	void free (void *ptr)
	{
	if (ptr == NIL) return;
	[...]
	}

This way all should work. However someone mentioned that the returns
from "malloc" should be unique. Why would that be? That would prohibit
my "1" trick. The statement implies you want to go about checking
pointers for equality. If for example you have a memcmp (a, b) that
has "if (a == b) return 0;" at the beginning. That would be allowed
for the NIL pointers. (all malloc-0 results SHOULD compare equal
anyway: there are 0 differences....)

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
*       Common sense is the collection of                                *
******  prejudices acquired by age eighteen.   -- Albert Einstein ********
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
