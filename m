Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269362AbUIYQ4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269362AbUIYQ4J (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 12:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269363AbUIYQ4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 12:56:09 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:28685 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269362AbUIYQz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 12:55:58 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Herbert Poetzl <herbert@13thfloor.at>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] [PPC64] [TRIVIAL] Janitor whitespace in pSeries_pci.c
Date: Sat, 25 Sep 2004 19:55:50 +0300
User-Agent: KMail/1.5.4
Cc: Linas Vepstas <linas@austin.ibm.com>, linux-kernel@vger.kernel.org,
       anton@samba.org, Andrew Morton <akpm@osdl.org>
References: <20040920221933.GB1872@austin.ibm.com> <16722.60814.732208.93234@cargo.ozlabs.ibm.com> <20040923160857.GB12071@MAIL.13thfloor.at>
In-Reply-To: <20040923160857.GB12071@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_WMaVByP7t0xwLQo"
Message-Id: <200409251955.50834.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_WMaVByP7t0xwLQo
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 23 September 2004 19:08, Herbert Poetzl wrote:
> On Thu, Sep 23, 2004 at 08:36:46AM -0700, Paul Mackerras wrote:
> > Herbert Poetzl writes:
> > 
> > > well, I'd like to know if full whitespace cleanup
> > > (trailing and indentation) _is_ something which
> > > is interesting for linux mainline ...
> > 
> > It's like this... you get to clean up the white space in a file (if
> > you want) IF you are also doing some useful work on the file - but the
> > whitespace cleanup and the useful work need to be separate patches in
> > order to ease later tracking of what changed.
> 
> ah, okay, so a larger patch cleaning up the
> whitespace issues in let's say linux/kernel or
> linux/fs would not be appreciated ...

Just in case, this is the script which can be used to generate patches
to fix whitespace in the tree. Unmodified script fixes only trailing ws
in printks and therefore ~250 generated patches have some chance of
acceptance.

Script has commented out code to fix all kinds of ws misuse.
If enabled, it produces nearly 50 MB worth of patches.
--
vda

--Boundary-00=_WMaVByP7t0xwLQo
Content-Type: application/x-shellscript;
  name="source_ws_autopatcher.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="source_ws_autopatcher.sh"

#!/bin/sh

tree=linux-2.6.7-bk20.src
prefix="source_ws"

dsttree="$prefix.$tree"

mkdir -p "$dsttree"
mkdir -p "$dsttree.patch"

echo "Note: $dsttree.patch/ directory must be empty, or you'll get duplicate patches"

{
# All files
#find "$tree"

# Files with bad whitespace
#grep -rl $'[ \t]$' "$tree"		# space or tab at EOL
#grep -rl  $'^[^ \t]       ' "$tree"	# char 7 spaces
#grep -rlF $' \t' "$tree"		# space tab
#grep -rlF $'\t ' "$tree"		# tab space 
#grep -rlF '        ' "$tree"		# 8 spaces

# Files with trailing whitespace in printk etc
# Why -i: DPRINTK and friends
grep -lri $'print.*[ \t]\\\\n' "$tree"
# '",' allows to filter out tons of false positives from asm()
grep -lr $'[ \t]\\\\n.*",' "$tree"

} \
| sort | uniq \
\
| while read -r file; do
    base=`basename "$file"`
    file2="$prefix.$file"

    # Names like irq.c.patch wouldn't be unique...
    patch="$base.patch"
    while test -e "$dsttree.patch/$patch"; do
	patch="$base-$RANDOM.patch"
    done

    echo "* $file"

    mkdir -p `dirname "$file2"`

    # Fix whitespace
    if false; then
    # begin 8spaces => begin tab
    # begin char 7spaces => begin char tab (repeat for 2,3,4...6 chars)
    # begin 1-7spaces tab => begin tab
    # tab 8spaces => tab tab (repeat)
    # tab 1-7spaces tab => tab tab (repeat)
    # trailing ws =>
    #| sed $'s/^        /\t/' \
    #| sed $'s/^\\([^ \t]\\)       /\\1\t/' \
    #| sed $'s/^ \\{1,7\\}\t/\t/' \
    #| sed $'s/\t        /\t\t/g' \
    #| sed $'s/\t \\{1,7\\}\t/\t\t/g' \
    #| sed $'s/[ \t]*$//' \
    cat "$file" \
    | sed $'s/^ \\{1,7\\}\t/\t/' \
    | sed -e $'s/\t        /\t\t/g' -e $'s/\t        /\t\t/g' \
          -e $'s/\t        /\t\t/g' -e $'s/\t        /\t\t/g' \
          -e $'s/\t        /\t\t/g' -e $'s/\t        /\t\t/g' \
    | sed -e $'s/\t \\{1,7\\}\t/\t\t/g' -e $'s/\t \\{1,7\\}\t/\t\t/g' \
          -e $'s/\t \\{1,7\\}\t/\t\t/g' -e $'s/\t \\{1,7\\}\t/\t\t/g' \
          -e $'s/\t \\{1,7\\}\t/\t\t/g' -e $'s/\t \\{1,7\\}\t/\t\t/g' \
    | sed $'s/[ \t]*$//' \
    > "$file2"
    fi

    # Fix whitespace in printks only
    # Multiple exprs handle stuff like:
    # printk(KERN_WARNING "ISILoad:Card%d rejected load header: \nAddress:0x%x \nCount:0x%x \nStatus:0x%x \n"
    # (multiple ' \n' occurences)
    # s/.../.../g would not help here
    cat "$file" \
    | sed -e $'s/[ \t]*\\\\n/\\\\n/' -e $'s/[ \t]*\\\\n/\\\\n/' \
          -e $'s/[ \t]*\\\\n/\\\\n/' -e $'s/[ \t]*\\\\n/\\\\n/' \
          -e $'s/[ \t]*\\\\n/\\\\n/' -e $'s/[ \t]*\\\\n/\\\\n/' \
          -e $'s/[ \t]*\\\\n/\\\\n/' -e $'s/[ \t]*\\\\n/\\\\n/' \
    > "$file2"

    if ! diff -up "$file" "$file2" >"$dsttree.patch/TEMP"; then
	mv "$dsttree.patch/TEMP" "$dsttree.patch/$patch"
    fi
done

rm "$dsttree.patch/TEMP" 2>/dev/null
echo "You may delete $dsttree now"

--Boundary-00=_WMaVByP7t0xwLQo--

