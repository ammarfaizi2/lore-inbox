Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261323AbTCJOh4>; Mon, 10 Mar 2003 09:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261325AbTCJOh4>; Mon, 10 Mar 2003 09:37:56 -0500
Received: from mail.bmlv.gv.at ([193.171.152.37]:6624 "HELO mail.bmlv.gv.at")
	by vger.kernel.org with SMTP id <S261323AbTCJOhw>;
	Mon, 10 Mar 2003 09:37:52 -0500
From: "Ph. Marek" <philipp.marek@bmlv.gv.at>
To: linux-kernel@vger.kernel.org
Subject: [Script] Changing the printk()s without KERNEL_ specification
Date: Mon, 10 Mar 2003 15:48:20 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0WKb+B1lYG0zEHN"
Message-Id: <200303101548.20945.philipp.marek@bmlv.gv.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_0WKb+B1lYG0zEHN
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello everybody,

Here's the latest version of my script.
I no longer advertise the patches as they are pretty big - for 2.5.64 it's
109022L and 3970383C.704649
bzip2'ed still 700KB - so I'm posting my script instead.

As some weeks ago it searches for occurrences of printk() without KERNEL_* - 
specifications (eg KERNEL_DEBUG) and changes these. It tries to be 
intelligent about that, ie it tracks if the last printk() in this function 
had a \n at the end or not - continued lines shouldn't be messed up with <?> 
characters.

This script couldn't parse the files (functions)
	./fs/umsdos/mangle.c	(umsdos_manglename)
	./fs/affs/super.c (affs_write_super)
	./sound/oss/emu10k1/audio.c (emu10k1_audio_ioctl)
	./sound/oss/sb_ess.c (ess_init)
	./sound/isa/sb/sb16.c (snd_sb16_probe)
	./sound/isa/opti9xx/opti92x-ad1848.c (snd_card_opti9xx_probe)
and
	./lib/zlib_deflate/deftree.c
- the first few because of #ifdef tricks with { or } and the last because of a 
#define.

In
	./lib/zlib_deflate/deftree.c
it correctly inserts a KERNEL_DEBUG - but as this printk() is the first in 
this function AND in a loop you'll have to use this patch:

diff -u crypto/tcrypt.c.orig crypto/tcrypt.c
--- crypto/tcrypt.c.orig        Wed Mar  5 04:29:33 2003
+++ crypto/tcrypt.c     Mon Mar 10 15:43:16 2003
@@ -55,6 +55,8 @@
 static void
 hexdump(unsigned char *buf, unsigned int len)
 {
+       printk(KERNEL_DEBUG);
+
        while (len--)
                printk("%02x", *buf++);

to make my script work.


Usage is like
	find . -iname "*.c" | xargs perl -i.bak ~/perl/change_printk.pl
so parts of the tree can be changed as well as the full tree.


Please let me know if you're using this script (just for my pride :-) and let 
me also know every problem you encounter.



Regards,

Phil


--Boundary-00=_0WKb+B1lYG0zEHN
Content-Type: text/x-perl;
  charset="us-ascii";
  name="change_printk.pl"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="change_printk.pl"

#!/usr/bin/perl


@DEAD=();

undef $/; # read complete files
  file:
while (<>)
{
  print STDERR $ARGV,"\n";
# read functions
  $fpos=0;
  while ( ($name)= 
      (m/(\w+)\s*\([^)]+?\)\s*(\x7b)/m) ) 
# can't use open-curly-bracket because of auto-indent
      {
	$start=$-[2];
	$body=substr($_,$start);

	$fpos+=$start;

	$index=1;
	$level=1;
	while($level)
	{
	  $l_o=index($body,'{',$index);
	  $l_c=index($body,'}',$index);
	  print STDERR "found: $l_o $l_c \n" ; #in <$body>\n";
	  if ($l_c < 0)
	  {
	    push @DEAD,"$ARGV:$name:$fpos";
print $_;
	    next file;
	  }

	  if ($l_c < $l_o || $l_o<0)
	  {
	    $level--;
	    $index=$l_c+1;
	  }
	  else
	  {
	    $level++;
	    $index=$l_o+1;
	  }
	}

	$text= substr($body,0,$index);
	print substr($_,0,$start),&Change($ARGV,$name,$text);
	substr($_,0,$start+$index)="";
	$fpos+=$index;
      }

  print $_;
}


if (@DEAD)
{
  print STDERR "\n\nDEAD FILES: ******************\n";
  print STDERR join("\n",@DEAD,"");
}

exit;


sub Change
{
  my($file,$func,$txt)=@_;
  my($sol,$index,$pk,$fmt,$parm,$is_kern,$e);
  my(%insert);


  $sol=1; # start of line set for function start

    %insert=();	# indizes to insert KERN_-values
    $index=-1;
  while (1)
  {
    print STDERR "$file:$func:$index\n";
    $index=index($txt,"printk",$index+1);
    last if $index == -1;

    if (substr($txt,$index-1,256) !~ m#\b(printk\s*\x28\s*)(\S[^,\x29]+\S)(\s*,[\x00-\xff]+?\S)?\s*\x29\s*;#)
    {
# not a real printk
      next;
    }

    ($pk,$fmt,$parm)=($1,$2,$3);
    $is_kern= $fmt =~ m#^KERN_#;

    if ($sol)
    {
      if ($is_kern)
      {
# ok
      }
      else
      {
# KERN_DEBUG missing
	$insert{$index + length($pk)}=" KERN_DEBUG ";
      }
    }
    else
    {
      if ($is_kern)
      {
	warn "possibly too much KERN_* at $file:$func:$index\n";
      }
      else
      {
# ok
      }
    }

# find \n in strings, and append a KERN_DEBUG if there's no " after \n
    $insert{$index + length($pk) + length($1)} = '" KERN_DEBUG "'
      while ($fmt =~ m#^([\x00-\xff]*\\n)(?!")#g);

    $sol = $fmt =~ m#\\n"$#;
  }

# from end to start, to avoid invalidating the indizes
  for (sort { $b <=> $a } keys %insert)
  {
    substr($txt,$_,0)=$insert{$_}
  }

  $txt;
}


__END__

while ( $txt =~ s#\b(printk\s*\x28\s*)(")#$1 KERN_DEBUG $2 #gx)
{
  print STDERR "in $file:$func:$txt\n";
}

## vim: sw=2 

--Boundary-00=_0WKb+B1lYG0zEHN--


