Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSDXJFO>; Wed, 24 Apr 2002 05:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311025AbSDXJFH>; Wed, 24 Apr 2002 05:05:07 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:24056 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S310979AbSDXJDu>; Wed, 24 Apr 2002 05:03:50 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020423080216.E25771@work.bitmover.com> 
To: Larry McVoy <lm@bitmover.com>
Cc: Jes Sorensen <jes@wildopensource.com>, Jeff Garzik <garzik@havoc.gtf.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Apr 2002 10:03:31 +0100
Message-ID: <22053.1019639011@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lm@bitmover.com said:
>  Sure, as soon as we find a mirror for bkbits.net, having a plain text
> interface to the files/patches, is a fine idea.  Until then, I need to
> hoard my bandwidth.  I'm working on the mirror problem.

These are already available on the kernel.org mirrors.

 http://ftp.??.kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5/
 http://ftp.??.kernel.org/pub/linux/kernel/people/

The individual patches look sane - I'm not entirely sure about the 'Full 
patch' version, which seems to contain stuff not in the individual patches.

<MODE REPLY-TO=!linux-kernel>

	Larry, any idea why? Script below...

</MODE>


#!/bin/sh
#
# $Id: bkexport.sh,v 1.10 2002/04/23 00:13:24 dwmw2 Exp $ 

BKDIR="$1"
PATCHDIR="$2"
CACHEDIR="$3"

if [ "$BKDIR" = "" -o "$PATCHDIR" = "" -o "$CACHEDIR" = "" ] ; then
    echo "Usage: $o <bkdir> <patchdir> <cachedir>"
    exit 1
fi

cd $PATCHDIR || exit 1

cd $CACHEDIR || exit 1

cd $BKDIR || exit 1

TAGCSET=`bk changes -t -d:I:\\\n | head -1`
TAG=`bk changes -r$TAGCSET -d:TAG:`

CSETS=`bk changes -d":I: " -r$TAGCSET,.`

NEWESTCSET=`echo $CSETS | cut -f1 -d\ `

if [ -r $PATCHDIR/cset-$TAGCSET-to-$NEWESTCSET.txt ]; then
    # We already ran with this set of changesets. Don't bother to rebuild.
   exit 0
fi

bk export -tpatch -r$TAGCSET,$NEWESTCSET > $PATCHDIR/cset-$TAGCSET-to-$NEWESTCSET.txt

cat > $CACHEDIR/newindex.$$.html <<EOF
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>BitKeeper patches for `hostname`:$BKDIR</title>
  </head>

  <body>
 <H1>BitKeeper patches since $TAG</H1>

 <H2><A HREF="cset-$TAGCSET-to-$NEWESTCSET.txt">Full patch from $TAG to ChangeSet $NEWESTCSET</A></H2>
 
EOF

for CSET in $CSETS; do
    if [ ! -r $PATCHDIR/cset-$CSET.txt -o  \
	 ! -r $CACHEDIR/cset-index-$CSET.html -o \
         ! -r $CACHEDIR/cset-key-$CSET -o \
	 "`cat $CACHEDIR/cset-key-$CSET 2>/dev/null`" != "`bk changes -r$CSET -d:KEY:`" ] ; then
	bk export -tpatch -r$CSET > $PATCHDIR/cset-$CSET.txt
        bk changes -r$CSET -d'<H3><A HREF="cset-:I:.txt">:G: :I:, :D: :T::TZ:, :USER: @ :HOST:</A></H3>\n<P>:HTML_C:</P>\n' > $CACHEDIR/cset-index-$CSET.html
	bk changes -r$CSET -d:KEY: > $CACHEDIR/cset-key-$CSET
    fi
    cat $CACHEDIR/cset-index-$CSET.html >> $CACHEDIR/newindex.$$.html
done

if [ "$CSETS" = "" ] ; then
    echo "<H3>No changes since last tag</h3>" >> $CACHEDIR/newindex.$$.html
EOF
fi

cat >> $CACHEDIR/newindex.$$.html <<EOF
  <hr>
  Index generated at `date -u`
  </body>
</HTML>
EOF
mv $CACHEDIR/newindex.$$.html $PATCHDIR/index.html


# Clean up old patches.
cd $PATCHDIR

for FILE in *.txt ; do 
    case $FILE in
    cset-$TAGCSET-to-$NEWESTCSET.txt)
	continue
	;;
    cset-*.txt)
	FILECSET=`echo $FILE | sed "s/^cset-\(.*\).txt\$/\\1/"`
	if ! echo $CSETS | grep -q -- $FILECSET ; then
	    rm "$FILE"
	fi
        continue
	;;
    esac

done

cd $CACHEDIR

for FILE in *.html ; do 
    case $FILE in
    index.html)
	continue
	;;
    cset-index-*.html)
	FILECSET=`echo $FILE | sed "s/^cset-index-\(.*\).html\$/\\1/"`
	if ! echo $CSETS | grep -q -- $FILECSET ; then
	    rm "$FILE"
	fi
	continue
	;;
    esac
done


--
dwmw2


