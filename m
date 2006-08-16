Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWHPV0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWHPV0c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 17:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWHPV0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 17:26:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:4336 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932230AbWHPV0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 17:26:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LhFAFJikswidqLmmS6OQCxOp4EroNVeBNxHNiXrYbR10Mho3+TasjxbJCnUthL0Wcvf6wJUSKModi8OWQbNaH7TXqJqoWa2F1eK6f01ylkt5X3CCRnesqdIsea3MKIVHXWKD0ZiMu4P84KAFtgHf0EloAzOS5+75g5BVZQgu5c8=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 'fbno' possibly used uninitialized in xfs_alloc_ag_vextent_small()
Date: Wed, 16 Aug 2006 23:27:34 +0200
User-Agent: KMail/1.9.4
Cc: Nathan Scott <nathans@sgi.com>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608162327.34420.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please keep me on Cc since I'm not subscribed to the XFS lists)

The coverity checker found what looks to me like a valid case of 
potentially uninitialized variable use (see below).


CID: 898
Checker: UNINIT (help)
File: base/src/linux-2.6/fs/xfs/xfs_alloc.c
Function: xfs_alloc_ag_vextent_small

...
1419 	STATIC int			/* error */
1420 	xfs_alloc_ag_vextent_small(
1421 		xfs_alloc_arg_t	*args,	/* allocation argument structure */
1422 		xfs_btree_cur_t	*ccur,	/* by-size cursor */
1423 		xfs_agblock_t	*fbnop,	/* result block number */
1424 		xfs_extlen_t	*flenp,	/* result length */
1425 		int		*stat)	/* status: 0-freelist, 1-normal/none */
1426 	{
1427 		int		error;

Event var_decl: Declared variable "fbno" without initializer
Also see events: [uninit_use]

1428 		xfs_agblock_t	fbno;
1429 		xfs_extlen_t	flen;
1430 	#ifdef XFS_ALLOC_TRACE
1431 		static char	fname[] = "xfs_alloc_ag_vextent_small";
1432 	#endif
1433 		int		i;
1434 	

At conditional (1): "error = xfs_alloc_decrement != 0" taking false path

1435 		if ((error = xfs_alloc_decrement(ccur, 0, &i)))
1436 			goto error0;

At conditional (2): "i != 0" taking false path

1437 		if (i) {
1438 			if ((error = xfs_alloc_get_rec(ccur, &fbno, &flen, &i)))
1439 				goto error0;
1440 			XFS_WANT_CORRUPTED_GOTO(i == 1, error0);
1441 		}
1442 		/*
1443 		 * Nothing in the btree, try the freelist.  Make sure
1444 		 * to respect minleft even when pulling from the
1445 		 * freelist.
1446 		 */

At conditional (3): "(args)->minlen == 1" taking true path
At conditional (4): "(args)->alignment == 1" taking true path
At conditional (5): "(args)->isfl == 0" taking true path
At conditional (6): "0" taking false path
At conditional (7): "((0) ? <expr:stmt_expr> : (__fswab32)) > (args)->minleft" taking false path

1447 		else if (args->minlen == 1 && args->alignment == 1 && !args->isfl &&
1448 			 (be32_to_cpu(XFS_BUF_TO_AGF(args->agbp)->agf_flcount)
1449 			  > args->minleft)) {
1450 			if ((error = xfs_alloc_get_freelist(args->tp, args->agbp, &fbno)))
1451 				goto error0;
1452 			if (fbno != NULLAGBLOCK) {
1453 				if (args->userdata) {
1454 					xfs_buf_t	*bp;
1455 	
1456 					bp = xfs_btree_get_bufs(args->mp, args->tp,
1457 						args->agno, fbno, 0);
1458 					xfs_trans_binval(args->tp, bp);
1459 				}
1460 				args->len = 1;
1461 				args->agbno = fbno;
1462 				XFS_WANT_CORRUPTED_GOTO(
1463 					args->agbno + args->len <=
1464 					be32_to_cpu(XFS_BUF_TO_AGF(args->agbp)->agf_length),
1465 					error0);
1466 				args->wasfromfl = 1;
1467 				TRACE_ALLOC("freelist", args);
1468 				*stat = 0;
1469 				return 0;
1470 			}
1471 			/*
1472 			 * Nothing in the freelist.
1473 			 */
1474 			else
1475 				flen = 0;
1476 		}
1477 		/*
1478 		 * Can't allocate from the freelist for some reason.
1479 		 */
1480 		else
1481 			flen = 0;
1482 		/*
1483 		 * Can't do the allocation, give up.
1484 		 */

At conditional (8): "flen < (args)->minlen" taking true path

1485 		if (flen < args->minlen) {
1486 			args->agbno = NULLAGBLOCK;
1487 			TRACE_ALLOC("notenough", args);
1488 			flen = 0;
1489 		}

Event uninit_use: Using uninitialized value "fbno"
Also see events: [var_decl]

1490 		*fbnop = fbno;
1491 		*flenp = flen;
1492 		*stat = 1;
1493 		TRACE_ALLOC("normal", args);
1494 		return 0;
1495 	
1496 	error0:
1497 		TRACE_ALLOC("error", args);
1498 		return error;
1499 	}
...


Or, with less noise :

 		if (i) {
 			if ((error = xfs_alloc_get_rec(ccur, &fbno, &flen, &i)))
...
 		}
... 
		else if (args->minlen == 1 && args->alignment == 1 && !args->isfl &&
 			 (be32_to_cpu(XFS_BUF_TO_AGF(args->agbp)->agf_flcount)
 			  > args->minleft)) {
 			if ((error = xfs_alloc_get_freelist(args->tp, args->agbp, &fbno)))
...
 		}
...
		else
 			flen = 0;
...
 		*fbnop = fbno;


So basically, if we hit the 'else' branch, then 'fbno' has not been 
initialized and line 1490 will then use that uninitialized variable.

What would prevent that from happening at some time??


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
 
  

