Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269158AbTCBIDa>; Sun, 2 Mar 2003 03:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269159AbTCBID3>; Sun, 2 Mar 2003 03:03:29 -0500
Received: from pdbn-d9bb8750.pool.mediaWays.net ([217.187.135.80]:29200 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S269158AbTCBID0>;
	Sun, 2 Mar 2003 03:03:26 -0500
Date: Sun, 2 Mar 2003 09:13:38 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Dan Kegel <dank@kegel.com>
Cc: Steven Cole <elenstev@mesatop.com>, Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
Message-ID: <20030302081338.GA2256@citd.de>
References: <Pine.LNX.4.44.0303011503590.29947-101000@korben.citd.de> <3E6101DE.5060301@kegel.com> <1046546305.10138.415.camel@spc1.mesatop.com> <3E6167B1.6040206@kegel.com> <3E617428.3090207@kegel.com> <20030302080910.GA2124@citd.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <20030302080910.GA2124@citd.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 02, 2003 at 09:09:10AM +0100, Matthias Schniedermeyer wrote:
> On Sat, Mar 01, 2003 at 07:02:00PM -0800, Dan Kegel wrote:
> > My corrections file is up at http://www.kegel.com/spell-fix-dan1.txt
> > and the patch that produces is
> > http://www.kegel.com/linux-2.5.63-bk5-spell.patch.bz2.bin
> > The perl script took about an hour of 450MHz cpu time.
> > (Might be worth adding a quick path to detect and skip
> > files with none of the misspelled words.  Or just run
> > on a fast machine...)
> 
> OK. Next Take.
> 
> Changes this time:
> - A bug-fix for "--dir" (Would have checked all files)
> - Added a "fast-path" but this doesn't seem to make a difference
> 
> New options:
> - "--[no]fix" to fix (default) or only look for errors.
>   (This ignores the '[no]comment'-option and looks for all errors!)
> - "--[no]override" to override(default) the original file or create a
>   "<filename>.fixed"-file
> 
> 
> Anyone wants a "--[no]ask"-option?

Earlier or later the "missing-attachment"-thing must happen to anyone.
:-)




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.


--Q68bSM7Ycu6FN28Q
Content-Type: application/x-perl
Content-Disposition: attachment; filename="spell-fix.pl"
Content-Transfer-Encoding: quoted-printable

#!/usr/bin/perl -w=0A=0Ause strict;=0Ause Getopt::Long;=0Ause vars qw (=0A	=
     $debug=0A	     %spell $spell_re=0A	     $spell_file=0A	     @input_fil=
es $input_file=0A	     @input_dirs  $input_dir=0A	     $onlycomments $do_fi=
x $do_override=0A	     $dir $path $fixed=0A	    );=0Ause subs qw (=0A	     =
init_commandline usage=0A	    );=0Asub check_file($);=0Asub check_content($=
$);=0A=0Ainit_commandline;=0A=0A# See if the spell-file is found in the cur=
rent-dir=0A# otherwise look in the dir from where we were started=0Aif (! -=
f $spell_file) {=0A  my $dir =3D $0;=0A  $dir =3D~ s/\/[^\/]+$/\//;=0A=0A  =
if (-f "$dir/$spell_file") {=0A    $spell_file =3D "$dir/$spell_file";=0A  =
}=0A}=0A=0A# -- Read file with the spellings --=0A# File-Format=0A# correct=
-word=3Dfalse,false,false...=0Aopen (FI, $spell_file) or die ("Can't open \=
"$spell_file\"");=0Awhile (<FI>) {=0A  s/\#.*$//;=0A  chomp;=0A  if ($_) {=
=0A    print "Input-Line: $_\n" if ($debug);=0A    my ($correct, $false_s) =
=3D split (/\s*=3D\s*/, $_, 2);=0A    $correct =3D~ s/^\s+//;=0A    $correc=
t =3D~ s/\s+$//;=0A    foreach my $false (split (/\s*,\s*/, $false_s)) {=0A=
      $false =3D~ s/^\s+//;=0A      $false =3D~ s/\s+$//;=0A      if ($fals=
e ne $correct) {=0A	print "Fix: \"$false\" -> \"correct\"\n" if ($debug);=
=0A	$spell{$false} =3D $correct;=0A      }=0A      else {=0A	warn ("Error i=
n Spell-file: \"$spell_file\" Line: $. \"$correct\" is the same for false &=
 correct");=0A      }=0A    }=0A  }=0A}=0Aclose (FI);=0A# -- End --=0A=0A# =
-- Create the regular expression --=0Amy @temp_spell;=0Aforeach my $key (so=
rt {$b cmp $a} keys %spell) {=0A  # For keys endig with a "\w"ord-charactar=
 we add a "\b"oundary.=0A  # Otherwise we get into trouble with words that =
begin the same but are longer=0A  my $postfix =3D $key =3D~ /\w$/ ? '\b' : =
'';=0A=0A  push @temp_spell, "\Q$key\E$postfix"=0A}=0A$spell_re =3D join ("=
\|", @temp_spell);=0Aprint "Spell_re: $spell_re\n" if ($debug);=0A# -- End =
--=0A=0A# Check files, if specified=0Aif ($#input_files >=3D 0) {=0A  forea=
ch $input_file (@input_files) {=0A    print "Checking file: \"$input_file\"=
\n" if ($debug);=0A    check_file ($input_file);=0A  }=0A}=0A=0A# Check dir=
s, if specified=0Aif ($#input_dirs >=3D 0) {=0A  foreach $input_dir (@input=
_dirs) {=0A    print "Checking dir: \"$input_dir\"\n" if ($debug);=0A    &t=
raverse($input_dir);=0A  }=0A}=0A=0A# When there was no file and/or dir arg=
ument(s) then process everything from current dir=0Aif ($#input_files =3D=
=3D -1 && $#input_dirs =3D=3D -1) {=0A  print "No dir/files specifed checki=
ng all files in the dir and subdirs\n" if ($debug);=0A  &traverse(".");=0A}=
=0A=0Asub init_commandline {=0A  my $helpopt   =3D 0;=0A  $debug        =3D=
 0;=0A  $spell_file   =3D "spell-fix.txt";=0A  @input_files  =3D ();=0A  @i=
nput_dirs   =3D ();=0A  $onlycomments =3D 1;=0A  $do_override  =3D 1;=0A  $=
do_fix       =3D 1;=0A=0A  my $result =3D GetOptions(=0A			  'help!'       =
   =3D> \$helpopt,=0A			  'spell-file=3Ds'   =3D> \$spell_file,=0A			  'fil=
e=3Ds'         =3D> \@input_files,=0A			  'dir=3Ds'          =3D> \@input_d=
irs,=0A			  'only-comments!' =3D> \$onlycomments,=0A			  'fix!'           =
=3D> \$do_fix,=0A			  'override!'      =3D> \$do_override,=0A			  'debug!' =
        =3D> \$debug,=0A			 );=0A=0A  usage() if $helpopt;=0A}=0A=0Asub usa=
ge {=0A  print <<"EOF";=0AUsage: $0 <options>, where valid options are=0A  =
  --help              # this message :-)=0A    --spell-file        # File w=
ith the correction-list=0A    --file <file>       # File(s) to be checked=
=0A    --dir <dir>         # Directory(s) to be checked (recursive!)=0A    =
--[no]only-comments # Only fix words inside a comment=0A    --[no]fix      =
     # Fix the errors? Or not?=0A    --[no]override      # Override the ori=
ginal file or create a ".fixed"-file?=0A    --debug             # Debugging=
-Messages=0AEOF=0A  exit(0);=0A}=0A=0Asub traverse {=0A  local($dir) =3D sh=
ift;=0A  local($path);=0A=0A  unless (opendir(DIR, $dir)) {=0A    warn "Can=
't open $dir\n";=0A    closedir(DIR);=0A    return;=0A  }=0A  foreach (read=
dir(DIR)) {=0A    next if $_ eq '.' || $_ eq '..';=0A    $path =3D "$dir/$_=
";=0A    if (-d $path) {         # a directory=0A      &traverse($path);=0A=
    }=0A    elsif (-f _) {        # a plain file=0A      check_file ($path)=
;=0A    }=0A  }=0A  closedir(DIR);=0A}=0A=0Asub check_file($) {=0A  my $fil=
e =3D shift;=0A  my $content;=0A  $fixed =3D 0;=0A  my $filenameprinted =3D=
 0;=0A=0A  open (FI, $file) or return;=0A  $content =3D join ("", <FI>);=0A=
  close (FI);=0A=0A  if ($debug || !$do_fix) {=0A    while ($content =3D~ /=
\b($spell_re)/g) {=0A      if (!$filenameprinted) {=0A	print "File: \"$file=
\"\n";=0A	$filenameprinted =3D 1;=0A      }=0A      print "False-Spelling: =
\"$1\" -> \"$spell{$1}\"\n";=0A    }=0A  }=0A=0A  # Correct spelling. Yes t=
he "core" is only a single substitution. :-)=0A  if ($do_fix) {=0A    if ($=
onlycomments) {=0A      # Take I "//"-Comments=0A      $content =3D~ s!(//)=
(.+)$!check_content($1,$2)!egm;=0A      # Take II "/* ... */"-Comments=0A  =
    $content =3D~ s!(/\*)(.+?)\*/!check_content($1,$2)!egs;=0A    }=0A    e=
lse {=0A      if ($content =3D~ s/\b($spell_re)/$spell{$1}/eg) {=0A	$fixed =
=3D 1;=0A      }=0A    }=0A  }=0A=0A  if ($fixed) {=0A    my $filename =3D =
$do_override ? "$file.tmp" : "$file.fixed";=0A=0A    print "False spellings=
 found. File: \"$file\"\n" if ($debug);=0A    # And write back the file.=0A=
    open (FO, ">$filename") or die ("Can't open file \"$filename\" for writ=
ing");=0A    print FO $content;=0A    close (FO);=0A=0A    if ($do_override=
) {=0A      rename ("$file", "$file.tmp2") or die ("Can't rename \"$file\" =
-> \"$file.tmp2\"");=0A      rename ("$file.tmp", "$file") or die ("Can't r=
ename \"$file.tmp\" -> \"$file\"");=0A      unlink ("$file.tmp2") or die ("=
Can't unlink \"$file.tmp2\"");=0A    }=0A  }=0A  else {=0A    print "No fal=
se spellings found. File: \"$file\"\n" if ($debug);=0A  }=0A}=0A=0Asub chec=
k_content($$) {=0A  my $comment =3D shift;=0A  my $content =3D shift;=0A=0A=
#  print "Comment: $comment\n";=0A#  print "content: $content\n";=0A=0A  if=
 ($content =3D~ s/\b($spell_re)/$spell{$1}/eg) {=0A    $fixed =3D 1;=0A  }=
=0A=0A  if ($comment eq "//") {=0A    return "//$content";=0A  }=0A  else {=
=0A    return "/*$content*/";=0A  }=0A}=0A
--Q68bSM7Ycu6FN28Q--
